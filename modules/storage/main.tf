resource "google_storage_bucket" "bucket" {
  name          = "${var.project_id}-${var.environment}-bucket"
  location      = var.region
  force_destroy = var.force_destroy

  labels = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )
}