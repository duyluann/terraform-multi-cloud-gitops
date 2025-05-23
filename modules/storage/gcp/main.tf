resource "google_storage_bucket" "bucket" {
  name          = "${var.project_id}-${var.environment}-bucket"
  location      = var.region
  force_destroy = var.force_destroy

  # Enable versioning
  versioning {
    enabled = true
  }

  # Enable uniform bucket-level access
  uniform_bucket_level_access = true

  # Enable logging
  logging {
    log_bucket = google_storage_bucket.logs.id
  }

  # Prevent public access
  public_access_prevention = "enforced"

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  labels = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
  })
}

# Create a separate bucket for logs
resource "google_storage_bucket" "logs" {
  name          = "${var.project_id}-${var.environment}-logs"
  location      = var.region
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  labels = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "logs"
  })
}
