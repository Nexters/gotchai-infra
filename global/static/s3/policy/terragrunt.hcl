include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/s3/policy"
}

dependency "bucket" {
  config_path = "../bucket"
  mock_outputs = {
    id = "gotchai-static"
  }
}

dependency "cloudfront" {
  config_path = "../../cloudfront"
  mock_outputs = {
    arn = "arn:aws:cloudfront::123456789012:distribution/EDFDVBD6EXAMPLE"
  }
}

inputs = {
  bucket_id = dependency.bucket.outputs.id
  policy = {
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = ["s3:GetObject"]
        Resource = "arn:aws:s3:::${dependency.bucket.outputs.id}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = dependency.cloudfront.outputs.arn
          }
        }
      }
    ]
  }
}
