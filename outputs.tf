output "build_definitions_id" {
  description = "Map of id values across all build_definitions, keyed the same as var.build_definitions except keys with no id are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.id if v.id != null && length(v.id) > 0 }
}
output "build_definitions_agent_pool_name" {
  description = "Map of agent_pool_name values across all build_definitions, keyed the same as var.build_definitions except keys with no agent_pool_name are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.agent_pool_name if v.agent_pool_name != null && length(v.agent_pool_name) > 0 }
}
output "build_definitions_agent_specification" {
  description = "Map of agent_specification values across all build_definitions, keyed the same as var.build_definitions except keys with no agent_specification are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.agent_specification if v.agent_specification != null && length(v.agent_specification) > 0 }
}
output "build_definitions_build_completion_trigger" {
  description = "Map of build_completion_trigger values across all build_definitions, keyed the same as var.build_definitions except keys with no build_completion_trigger are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.build_completion_trigger if v.build_completion_trigger != null && length(v.build_completion_trigger) > 0 }
}
output "build_definitions_ci_trigger" {
  description = "Map of ci_trigger values across all build_definitions, keyed the same as var.build_definitions except keys with no ci_trigger are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => one(v.ci_trigger) if v.ci_trigger != null && length(v.ci_trigger) > 0 }
}
output "build_definitions_features" {
  description = "Map of features values across all build_definitions, keyed the same as var.build_definitions except keys with no features are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.features if v.features != null && length(v.features) > 0 }
}
output "build_definitions_job_authorization_scope" {
  description = "Map of job_authorization_scope values across all build_definitions, keyed the same as var.build_definitions except keys with no job_authorization_scope are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.job_authorization_scope if v.job_authorization_scope != null && length(v.job_authorization_scope) > 0 }
}
output "build_definitions_jobs" {
  description = "Map of jobs values across all build_definitions, keyed the same as var.build_definitions except keys with no jobs are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.jobs if v.jobs != null && length(v.jobs) > 0 }
}
output "build_definitions_name" {
  description = "Map of name values across all build_definitions, keyed the same as var.build_definitions except keys with no name are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.name if v.name != null && length(v.name) > 0 }
}
output "build_definitions_path" {
  description = "Map of path values across all build_definitions, keyed the same as var.build_definitions except keys with no path are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.path if v.path != null && length(v.path) > 0 }
}
output "build_definitions_project_id" {
  description = "Map of project_id values across all build_definitions, keyed the same as var.build_definitions except keys with no project_id are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.project_id if v.project_id != null && length(v.project_id) > 0 }
}
output "build_definitions_pull_request_trigger" {
  description = "Map of pull_request_trigger values across all build_definitions, keyed the same as var.build_definitions except keys with no pull_request_trigger are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => one(v.pull_request_trigger) if v.pull_request_trigger != null && length(v.pull_request_trigger) > 0 }
}
output "build_definitions_queue_status" {
  description = "Map of queue_status values across all build_definitions, keyed the same as var.build_definitions except keys with no queue_status are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.queue_status if v.queue_status != null && length(v.queue_status) > 0 }
}
output "build_definitions_repository" {
  description = "Map of repository values across all build_definitions, keyed the same as var.build_definitions except keys with no repository are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => one(v.repository) if v.repository != null && length(v.repository) > 0 }
}
output "build_definitions_revision" {
  description = "Map of revision values across all build_definitions, keyed the same as var.build_definitions except keys with no revision are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.revision if v.revision != null }
}
output "build_definitions_schedules" {
  description = "Map of schedules values across all build_definitions, keyed the same as var.build_definitions except keys with no schedules are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.schedules if v.schedules != null && length(v.schedules) > 0 }
}
output "build_definitions_variable" {
  description = "Map of variable values across all build_definitions, keyed the same as var.build_definitions except keys with no variable are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.variable if v.variable != null && length(v.variable) > 0 }
  sensitive   = true
}
output "build_definitions_variable_groups" {
  description = "Map of variable_groups values across all build_definitions, keyed the same as var.build_definitions except keys with no variable_groups are omitted"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.variable_groups if v.variable_groups != null && length(v.variable_groups) > 0 }
}

