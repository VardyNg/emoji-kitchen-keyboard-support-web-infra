resource "azuredevops_project" "web" {
  name               = "${var.app_name}-project"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Project for ${var.app_name}"
  features = {
    "testplans" = "disabled"
    "artifacts" = "disabled"
  }
}

resource "azuredevops_serviceendpoint_github" "web-repo" {
  project_id            = azuredevops_project.web.id
  service_endpoint_name = "Example GitHub Personal Access Token"

  auth_personal {
    personal_access_token = var.web_github_pat
  }
}

resource "azuredevops_build_definition" "web-build" {
  project_id = azuredevops_project.web.id
  name       = "Web Build Definition"
  path       = "\\"

  ci_trigger {
    use_yaml = false
  }

  repository {
    repo_type   = "GitHub"
    repo_id     = "VardyNg/emoji-kitchen-keyboard-support-web"
    yml_path    = "azure-pipelines.yml"
    branch_name = "prod"
    service_connection_id = azuredevops_serviceendpoint_github.web-repo.id
  }
}
