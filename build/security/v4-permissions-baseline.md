# Golden Path v4 — Permission Baseline (opencode debug)

| Agent | mode | edit | write | bash | task | skill | editAllow | editDeny | bashDeny | skillAllow |
|---|---|---|---|---|---|---|---|---|---|---|
| build (orchestrator) | primary | False | False | True(ask) | True | True | - | * | - | (all) |
| 1c-architect | subagent | False | False | True(ask) | True | True | - | * | - | 1c-core, 1c-metadata-probe, 1c-platform, 1c-metadata-engineering, 1c-bsl-engineering, 1c-ai-tooling |
| 1c-developer | subagent | True | True | True(ask) | True | True | src/** | * | *1cv8.exe* | 1c-core, 1c-managed-form, 1c-build-epf, 1c-platform, 1c-metadata-engineering, 1c-bsl-engineering, 1c-managed-form-engineering, 1c-epf-erf-engineering, 1c-query-skd, 1c-testing-verification |
| 1c-reviewer | subagent | False | False | True(ask) | True | True | - | * | - | 1c-core, 1c-managed-form, 1c-testing, 1c-platform, 1c-metadata-engineering, 1c-bsl-engineering, 1c-managed-form-engineering, 1c-epf-erf-engineering, 1c-query-skd, 1c-testing-verification |
| 1c-tester | subagent | False | False | True(ask) | True | True | - | * | - | 1c-build-epf, 1c-testing, 1c-platform, 1c-metadata-engineering, 1c-bsl-engineering, 1c-managed-form-engineering, 1c-epf-erf-engineering, 1c-query-skd, 1c-testing-verification, 1c-ai-tooling |
| 1c-auditor | subagent | False | False | True(ask) | True | True | - | * | - | 1c-core, 1c-testing, 1c-platform, 1c-metadata-engineering, 1c-bsl-engineering, 1c-managed-form-engineering, 1c-epf-erf-engineering, 1c-query-skd, 1c-testing-verification, 1c-ai-tooling |

model: build=deepseek/deepseek-v4-pro, variant=high; subagents наследуют top-level model.