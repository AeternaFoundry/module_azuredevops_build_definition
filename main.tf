resource "azuredevops_build_definition" "build_definitions" {
  for_each = var.build_definitions

  name                    = each.value.name
  project_id              = each.value.project_id
  agent_pool_name         = each.value.agent_pool_name
  agent_specification     = each.value.agent_specification
  job_authorization_scope = each.value.job_authorization_scope
  path                    = each.value.path
  queue_status            = each.value.queue_status
  variable_groups         = each.value.variable_groups

  repository {
    branch_name           = each.value.repository.branch_name
    github_enterprise_url = each.value.repository.github_enterprise_url
    repo_id               = each.value.repository.repo_id
    repo_type             = each.value.repository.repo_type
    report_build_status   = each.value.repository.report_build_status
    service_connection_id = each.value.repository.service_connection_id
    url                   = each.value.repository.url
    yml_path              = each.value.repository.yml_path
  }

  dynamic "build_completion_trigger" {
    for_each = each.value.build_completion_trigger != null ? each.value.build_completion_trigger : []
    content {
      dynamic "branch_filter" {
        for_each = build_completion_trigger.value.branch_filter
        content {
          exclude = branch_filter.value.exclude
          include = branch_filter.value.include
        }
      }
      build_definition_id = build_completion_trigger.value.build_definition_id
    }
  }

  dynamic "ci_trigger" {
    for_each = each.value.ci_trigger != null ? [each.value.ci_trigger] : []
    content {
      dynamic "override" {
        for_each = ci_trigger.value.override != null ? [ci_trigger.value.override] : []
        content {
          batch = override.value.batch
          dynamic "branch_filter" {
            for_each = override.value.branch_filter
            content {
              exclude = branch_filter.value.exclude
              include = branch_filter.value.include
            }
          }
          max_concurrent_builds_per_branch = override.value.max_concurrent_builds_per_branch
          dynamic "path_filter" {
            for_each = override.value.path_filter != null ? override.value.path_filter : []
            content {
              exclude = path_filter.value.exclude
              include = path_filter.value.include
            }
          }
          polling_interval = override.value.polling_interval
        }
      }
      use_yaml = ci_trigger.value.use_yaml
    }
  }

  dynamic "features" {
    for_each = each.value.features != null ? each.value.features : []
    content {
      skip_first_run = features.value.skip_first_run
    }
  }

  dynamic "jobs" {
    for_each = each.value.jobs != null ? each.value.jobs : []
    content {
      allow_scripts_auth_access_option = jobs.value.allow_scripts_auth_access_option
      condition                        = jobs.value.condition
      dynamic "dependencies" {
        for_each = jobs.value.dependencies != null ? jobs.value.dependencies : []
        content {
          scope = dependencies.value.scope
        }
      }
      job_authorization_scope       = jobs.value.job_authorization_scope
      job_cancel_timeout_in_minutes = jobs.value.job_cancel_timeout_in_minutes
      job_timeout_in_minutes        = jobs.value.job_timeout_in_minutes
      name                          = jobs.value.name
      ref_name                      = jobs.value.ref_name
      target {
        demands = jobs.value.target.demands
        execution_options {
          continue_on_error = jobs.value.target.execution_options.continue_on_error
          max_concurrency   = jobs.value.target.execution_options.max_concurrency
          multipliers       = jobs.value.target.execution_options.multipliers
          type              = jobs.value.target.execution_options.type
        }
        type = jobs.value.target.type
      }
    }
  }

  dynamic "pull_request_trigger" {
    for_each = each.value.pull_request_trigger != null ? [each.value.pull_request_trigger] : []
    content {
      comment_required = pull_request_trigger.value.comment_required
      forks {
        enabled       = pull_request_trigger.value.forks.enabled
        share_secrets = pull_request_trigger.value.forks.share_secrets
      }
      initial_branch = pull_request_trigger.value.initial_branch
      dynamic "override" {
        for_each = pull_request_trigger.value.override != null ? [pull_request_trigger.value.override] : []
        content {
          auto_cancel = override.value.auto_cancel
          dynamic "branch_filter" {
            for_each = override.value.branch_filter
            content {
              exclude = branch_filter.value.exclude
              include = branch_filter.value.include
            }
          }
          dynamic "path_filter" {
            for_each = override.value.path_filter != null ? override.value.path_filter : []
            content {
              exclude = path_filter.value.exclude
              include = path_filter.value.include
            }
          }
        }
      }
      use_yaml = pull_request_trigger.value.use_yaml
    }
  }

  dynamic "schedules" {
    for_each = each.value.schedules != null ? each.value.schedules : []
    content {
      dynamic "branch_filter" {
        for_each = schedules.value.branch_filter
        content {
          exclude = branch_filter.value.exclude
          include = branch_filter.value.include
        }
      }
      days_to_build              = schedules.value.days_to_build
      schedule_only_with_changes = schedules.value.schedule_only_with_changes
      start_hours                = schedules.value.start_hours
      start_minutes              = schedules.value.start_minutes
      time_zone                  = schedules.value.time_zone
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  dynamic "variable" {
    for_each = each.value.variable != null ? each.value.variable : []
    content {
      allow_override = variable.value.allow_override
      is_secret      = variable.value.is_secret
      name           = variable.value.name
      secret_value   = variable.value.secret_value
      value          = variable.value.value
    }
  }
}

