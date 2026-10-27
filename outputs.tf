output "build_definitions_id" {
  description = "Map of id values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.id }
}
output "build_definitions_agent_pool_name" {
  description = "Map of agent_pool_name values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.agent_pool_name }
}
output "build_definitions_agent_specification" {
  description = "Map of agent_specification values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.agent_specification }
}
output "build_definitions_build_completion_trigger" {
  description = "Map of build_completion_trigger values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.build_completion_trigger }
}
output "build_definitions_ci_trigger" {
  description = "Map of ci_trigger values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => one(v.ci_trigger) }
}
output "build_definitions_features" {
  description = "Map of features values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.features }
}
output "build_definitions_job_authorization_scope" {
  description = "Map of job_authorization_scope values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.job_authorization_scope }
}
output "build_definitions_jobs" {
  description = "Map of jobs values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.jobs }
}
output "build_definitions_name" {
  description = "Map of name values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.name }
}
output "build_definitions_path" {
  description = "Map of path values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.path }
}
output "build_definitions_project_id" {
  description = "Map of project_id values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.project_id }
}
output "build_definitions_pull_request_trigger" {
  description = "Map of pull_request_trigger values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => one(v.pull_request_trigger) }
}
output "build_definitions_queue_status" {
  description = "Map of queue_status values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.queue_status }
}
output "build_definitions_repository" {
  description = "Map of repository values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => one(v.repository) }
}
output "build_definitions_revision" {
  description = "Map of revision values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.revision }
}
output "build_definitions_schedules" {
  description = "Map of schedules values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.schedules }
}
output "build_definitions_variable" {
  description = "Map of variable values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.variable }
  sensitive   = true
}
output "build_definitions_variable_groups" {
  description = "Map of variable_groups values across all build_definitions, keyed the same as var.build_definitions"
  value       = { for k, v in azuredevops_build_definition.build_definitions : k => v.variable_groups }
}

