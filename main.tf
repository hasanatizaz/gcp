provider "google" {
  credentials = file("optical-weft-321006-d44f20dcc73f.json")
  project     = "optical-weft-321006"
  region      = "us-west1"
  zone        = "us-west1-b"

}
resource "google_service_account" "service_account" {
  account_id   = "custom-terraform"
  display_name = "custom-terraform"
}

resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.serviceAccountUser"
  member             = "user:hasanatizaz@gmail.com"
}

resource "google_project_iam_custom_role" "terraform-custom-role" {
  role_id     = "mycustomterraformroles"
  title       = "Terraform Custom"
  description = "Role Created through terraform"
  permissions = ["apikeys.keys.create", "apikeys.keys.delete"]
}
resource "google_project_iam_binding" "terraform-binding" {
project = "optical-weft-321006"
role = "projects/optical-weft-321006/roles/${google_project_iam_custom_role.terraform-custom-role.role_id}"
  members = [
    "serviceAccount:terraform@optical-weft-321006.iam.gserviceaccount.com",
  ]
}


resource "google_service_account" "service_accounts" {
  account_id   = "custom-terraform3"
  display_name = "custom-terraform3"
}

resource "google_project_iam_binding" "terraform-bindings" {
project = "optical-weft-321006"
role = "roles/compute.viewer"
  members = [
      "serviceAccount:custom-terraform3@optical-weft-321006.iam.gserviceaccount.com",
  ]
}
