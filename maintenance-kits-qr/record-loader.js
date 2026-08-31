/* Fail-closed record registry loader helpers. */
function norm(value) {
  return String(value ?? "").trim().toUpperCase();
}

export function findRecordEntry(registry, sku, revision) {
  if (!registry || !Array.isArray(registry.records)) return null;
  const s = norm(sku);
  const r = norm(revision);
  if (!s || !r) return null;
  return registry.records.find((entry) => norm(entry?.sku) === s && norm(entry?.revision) === r) ?? null;
}

export function safeRecordPath(entry) {
  const path = String(entry?.path ?? "").trim();
  if (!path) return null;
  if (path.startsWith("/") || path.includes("..") || path.includes("\\") || !path.endsWith(".json")) return null;
  if (!/^[A-Za-z0-9._/-]+$/.test(path)) return null;
  return path;
}

export function selectDefaultEntry(registry) {
  if (!registry || !Array.isArray(registry.records) || registry.records.length !== 1) return null;
  return registry.records[0] ?? null;
}
