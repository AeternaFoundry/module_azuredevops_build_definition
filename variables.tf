variable "build_definitions" {
  description = <<EOT
Map of build_definitions, attributes below
Required:
    - name
    - project_id
    - repository (block):
        - branch_name (optional)
        - github_enterprise_url (optional)
        - repo_id (required)
        - repo_type (required)
        - report_build_status (optional)
        - service_connection_id (optional)
        - url (optional)
        - yml_path (optional)
Optional:
    - agent_pool_name
    - agent_specification
    - job_authorization_scope
    - path
    - queue_status
    - variable_groups
    - build_completion_trigger (block):
        - branch_filter (required, block):
            - exclude (optional)
            - include (optional)
        - build_definition_id (required)
    - ci_trigger (block):
        - override (optional, block):
            - batch (optional)
            - branch_filter (required, block):
                - exclude (optional)
                - include (optional)
            - max_concurrent_builds_per_branch (optional)
            - path_filter (optional, block):
                - exclude (optional)
                - include (optional)
            - polling_interval (optional)
        - use_yaml (optional)
    - features (block):
        - skip_first_run (optional)
    - jobs (block):
        - allow_scripts_auth_access_option (optional)
        - condition (required)
        - dependencies (optional, block):
            - scope (required)
        - job_authorization_scope (optional)
        - job_cancel_timeout_in_minutes (optional)
        - job_timeout_in_minutes (optional)
        - name (required)
        - ref_name (required)
        - target (required, block):
            - demands (optional)
            - execution_options (required, block):
                - continue_on_error (optional)
                - max_concurrency (optional)
                - multipliers (optional)
                - type (required)
            - type (required)
    - pull_request_trigger (block):
        - comment_required (optional)
        - forks (required, block):
            - enabled (required)
            - share_secrets (required)
        - initial_branch (optional)
        - override (optional, block):
            - auto_cancel (optional)
            - branch_filter (required, block):
                - exclude (optional)
                - include (optional)
            - path_filter (optional, block):
                - exclude (optional)
                - include (optional)
        - use_yaml (optional)
    - schedules (block):
        - branch_filter (required, block):
            - exclude (optional)
            - include (optional)
        - days_to_build (required)
        - schedule_only_with_changes (optional)
        - start_hours (optional)
        - start_minutes (optional)
        - time_zone (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
    - variable (block):
        - allow_override (optional)
        - is_secret (optional)
        - name (required)
        - secret_value (optional)
        - value (optional)
EOT

  type = map(object({
    name                    = string
    project_id              = string
    agent_pool_name         = optional(string)
    agent_specification     = optional(string)
    job_authorization_scope = optional(string)
    path                    = optional(string)
    queue_status            = optional(string)
    variable_groups         = optional(set(number))
    repository = object({
      branch_name           = optional(string)
      github_enterprise_url = optional(string)
      repo_id               = string
      repo_type             = string
      report_build_status   = optional(bool)
      service_connection_id = optional(string)
      url                   = optional(string)
      yml_path              = optional(string)
    })
    build_completion_trigger = optional(list(object({
      branch_filter = list(object({
        exclude = optional(set(string))
        include = optional(set(string))
      }))
      build_definition_id = number
    })))
    ci_trigger = optional(object({
      override = optional(object({
        batch = optional(bool)
        branch_filter = list(object({
          exclude = optional(set(string))
          include = optional(set(string))
        }))
        max_concurrent_builds_per_branch = optional(number)
        path_filter = optional(list(object({
          exclude = optional(set(string))
          include = optional(set(string))
        })))
        polling_interval = optional(number)
      }))
      use_yaml = optional(bool)
    }))
    features = optional(list(object({
      skip_first_run = optional(bool)
    })))
    jobs = optional(list(object({
      allow_scripts_auth_access_option = optional(bool)
      condition                        = string
      dependencies = optional(list(object({
        scope = string
      })))
      job_authorization_scope       = optional(string)
      job_cancel_timeout_in_minutes = optional(number)
      job_timeout_in_minutes        = optional(number)
      name                          = string
      ref_name                      = string
      target = object({
        demands = optional(list(string))
        execution_options = object({
          continue_on_error = optional(bool)
          max_concurrency   = optional(number)
          multipliers       = optional(string)
          type              = string
        })
        type = string
      })
    })))
    pull_request_trigger = optional(object({
      comment_required = optional(string)
      forks = object({
        enabled       = bool
        share_secrets = bool
      })
      initial_branch = optional(string)
      override = optional(object({
        auto_cancel = optional(bool)
        branch_filter = list(object({
          exclude = optional(set(string))
          include = optional(set(string))
        }))
        path_filter = optional(list(object({
          exclude = optional(set(string))
          include = optional(set(string))
        })))
      }))
      use_yaml = optional(bool)
    }))
    schedules = optional(list(object({
      branch_filter = list(object({
        exclude = optional(set(string))
        include = optional(set(string))
      }))
      days_to_build              = list(string)
      schedule_only_with_changes = optional(bool)
      start_hours                = optional(number)
      start_minutes              = optional(number)
      time_zone                  = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
    variable = optional(list(object({
      allow_override = optional(bool)
      is_secret      = optional(bool)
      name           = string
      secret_value   = optional(string)
      value          = optional(string)
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.build_completion_trigger == null || alltrue([for item in v.build_completion_trigger : (length(item.branch_filter) >= 1)])
      )
    ])
    error_message = "Each branch_filter list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.ci_trigger == null || (v.ci_trigger.override == null || (length(v.ci_trigger.override.branch_filter) >= 1))
      )
    ])
    error_message = "Each branch_filter list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.pull_request_trigger == null || (v.pull_request_trigger.override == null || (length(v.pull_request_trigger.override.branch_filter) >= 1))
      )
    ])
    error_message = "Each branch_filter list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.schedules == null || alltrue([for item in v.schedules : (length(item.branch_filter) >= 1)])
      )
    ])
    error_message = "Each branch_filter list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        length(trimspace(v.name)) > 0
      )
    ])
    error_message = "must not be empty or only whitespace"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.path == null || (length(v.path) >= 1)
      )
    ])
    error_message = "[from validate.Path: invalid when len(value) < 1]"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.variable_groups == null || (alltrue([for x in v.variable_groups : x >= 1]))
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.pull_request_trigger == null || (v.pull_request_trigger.comment_required == null || (contains(["All", "NonTeamMembers"], v.pull_request_trigger.comment_required)))
      )
    ])
    error_message = "must be one of: \"All\", \"NonTeamMembers\""
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.agent_specification == null || (length(v.agent_specification) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (length(item.name) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (length(item.ref_name) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (length(item.condition) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (item.dependencies == null || alltrue([for item in item.dependencies : (length(item.scope) > 0)]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (item.target.execution_options.max_concurrency == null || (item.target.execution_options.max_concurrency >= 1 && item.target.execution_options.max_concurrency <= 99))])
      )
    ])
    error_message = "must be between 1 and 99"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (item.target.execution_options.multipliers == null || (length(item.target.execution_options.multipliers) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (item.job_timeout_in_minutes == null || (item.job_timeout_in_minutes >= 0 && item.job_timeout_in_minutes <= 1000000000))])
      )
    ])
    error_message = "must be between 0 and 1000000000"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.jobs == null || alltrue([for item in v.jobs : (item.job_cancel_timeout_in_minutes == null || (item.job_cancel_timeout_in_minutes >= 0 && item.job_cancel_timeout_in_minutes <= 60))])
      )
    ])
    error_message = "must be between 0 and 60"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.schedules == null || alltrue([for item in v.schedules : (alltrue([for x in item.days_to_build : contains(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], x)]))])
      )
    ])
    error_message = "must be one of: \"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\""
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.schedules == null || alltrue([for item in v.schedules : (item.start_hours == null || (item.start_hours >= 0 && item.start_hours <= 23))])
      )
    ])
    error_message = "must be between 0 and 23"
  }
  validation {
    condition = alltrue([
      for k, v in var.build_definitions : (
        v.schedules == null || alltrue([for item in v.schedules : (item.start_minutes == null || (item.start_minutes >= 0 && item.start_minutes <= 59))])
      )
    ])
    error_message = "must be between 0 and 59"
  }
  # Note: 15 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

