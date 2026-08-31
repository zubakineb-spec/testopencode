/* Premium Maintenance Kits — fail-closed QR resolver prototype R1 */
export const RESULT = Object.freeze({
  GREEN: "GREEN",
  CHECK_REQUIRED: "CHECK_REQUIRED",
  NOT_COMPATIBLE: "NOT_COMPATIBLE",
  HOLD: "HOLD",
});

const GREEN_GATES = [
  "tech", "vin_epc", "physical", "doc", "pack", "brand_tm", "qr_rev", "econ", "supplier",
];

function normalize(value) {
  return String(value ?? "").trim().toUpperCase();
}

function allReleaseGatesGreen(record) {
  const gates = record?.release_gates ?? {};
  return GREEN_GATES.every((key) => gates[key] === "GREEN");
}

function exactReleasedRecord(record) {
  return Boolean(record && record.record_status === "RELEASED" && record.fitment_status === "GREEN" && allReleaseGatesGreen(record));
}

function knownConflict(record, vehicle) {
  if (!record || !vehicle) return false;
  if (record.fitment_status === "NOT_COMPATIBLE") return true;
  const scope = record.vehicle_scope ?? {};
  if (vehicle.make && scope.make && normalize(vehicle.make) !== normalize(scope.make)) return true;
  if (vehicle.model && scope.model && normalize(vehicle.model) !== normalize(scope.model)) return true;
  for (const field of ["engine", "transmission", "drivetrain"]) {
    if (vehicle[field] && scope[field] && normalize(vehicle[field]) !== normalize(scope[field])) return true;
  }
  return false;
}

function scopeNeedsMoreEvidence(record, vehicle) {
  const rule = record?.build_vin_rule?.mode;
  if (!vehicle) return true;
  if (rule === "BLOCKED") return true;
  if (rule === "VIN_REQUIRED" && !vehicle.vin_verified) return true;
  if (rule === "BUILD_REQUIRED" && !vehicle.build_verified) return true;
  if (rule === "VIN_OR_BUILD_REQUIRED" && !vehicle.vin_verified && !vehicle.build_verified) return true;
  return false;
}

export function resolveCompatibility(record, vehicle = null) {
  if (!record || !record.sku || !record.revision) {
    return { result: RESULT.HOLD, reason: "INVALID_OR_UNKNOWN_REVISION", install_allowed: false };
  }
  if (record.record_status === "RETIRED" || record.record_status === "HOLD") {
    return { result: RESULT.HOLD, reason: "REVISION_NOT_RELEASED", install_allowed: false };
  }
  if (record.kit_lot === "BLOCKED") {
    return { result: RESULT.HOLD, reason: "LOT_BLOCKED", install_allowed: false };
  }
  if (knownConflict(record, vehicle)) {
    return { result: RESULT.NOT_COMPATIBLE, reason: "VEHICLE_SCOPE_CONFLICT", install_allowed: false };
  }
  if (!exactReleasedRecord(record)) {
    return { result: RESULT.CHECK_REQUIRED, reason: "RELEASE_GATES_INCOMPLETE", install_allowed: false };
  }
  if (scopeNeedsMoreEvidence(record, vehicle)) {
    return { result: RESULT.CHECK_REQUIRED, reason: "VIN_OR_BUILD_VERIFICATION_REQUIRED", install_allowed: false };
  }
  return { result: RESULT.GREEN, reason: "EXACT_RELEASED_SCOPE", install_allowed: true };
}
