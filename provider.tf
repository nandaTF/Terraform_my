provider "google" {
  project     = "smiling-office-365211"
  credentials = file("cred.json")
  region      = "us-central1"
  zone        = "us-central-a"
}
