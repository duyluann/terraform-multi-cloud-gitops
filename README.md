# Terraform Multi-Cloud GitOps Template

A production-ready Terraform template for managing multi-cloud infrastructure using GitOps principles, with built-in security scanning and compliance checks.

## Features

- **Multi-Cloud Support**
  - Google Cloud Platform (GCP)
  - Amazon Web Services (AWS)
  - Microsoft Azure
  - Provider-specific modules and configurations

- **GitOps Workflow**
  - Environment promotion (dev → staging → prod)
  - Automated deployments
  - Pull request-based changes
  - State management per environment

- **Security & Compliance**
  - Pre-commit hooks for code quality
  - Automated security scanning (TFSec, Checkov)
  - Infrastructure linting (TFLint)
  - Compliance checking
  - Environment-specific security rules

## Cloud Provider Credentials Setup

This template requires credentials for each cloud provider you plan to use. Follow these steps to configure the credentials in GitHub:

### 1. Create GitHub Environments

First, create environments in your GitHub repository:

1. Go to your repository settings
2. Navigate to "Environments"
3. Create three environments:
   - `dev`
   - `staging`
   - `prod`

### 2. Configure Cloud Provider Credentials

For each environment, add the required secrets following the official GitHub Actions documentation:

- **AWS**: Follow [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials)
- **GCP**: Follow [google-github-actions/auth](https://github.com/google-github-actions/auth)
- **Azure**: Follow [azure/login](https://github.com/Azure/login)

### 3. Verify Credentials

The workflow includes debug steps that will show if credentials are properly configured. You should see:

```bash
Environment: dev
AWS_ACCESS_KEY_ID: ***
AWS_SECRET_ACCESS_KEY: ***
AWS_REGION: ***
GOOGLE_CREDENTIALS: ***
AZURE_CREDENTIALS: ***
```

If any shows "NOT SET", that secret needs to be configured.

### 4. Environment Protection Rules (Optional)

For each environment, you can configure:
- Required reviewers
- Wait timer
- Branch restrictions
- Deployment branch rules

## Repository Structure

```
.
├── environments/                    # Environment-specific configurations
│   ├── dev/                        # Development environment
│   │   ├── main.tf                # Main configuration
│   │   ├── variables.tf           # Input variables
│   │   ├── outputs.tf             # Output values
│   │   └── versions.tf            # Provider versions
│   ├── staging/                    # Staging environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── versions.tf
│   └── prod/                       # Production environment
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── versions.tf
├── modules/                        # Reusable Terraform modules
│   ├── compute/                    # Compute resources
│   │   ├── gcp/                   # GCP Compute Engine
│   │   ├── aws/                   # AWS EC2
│   │   └── azure/                 # Azure VM
│   ├── storage/                    # Storage resources
│   │   ├── gcp/                   # GCP Cloud Storage
│   │   ├── aws/                   # AWS S3
│   │   └── azure/                 # Azure Storage
│   ├── database/                   # Database resources
│   │   ├── gcp/                   # GCP Cloud SQL
│   │   ├── aws/                   # AWS RDS
│   │   └── azure/                 # Azure SQL
│   └── networking/                 # Networking resources
│       ├── gcp/                   # GCP VPC
│       ├── aws/                   # AWS VPC
│       └── azure/                 # Azure VNet
├── .github/                       # GitHub Actions workflows
│   └── workflows/
│       └── terraform.yml         # Main Terraform workflow
├── .pre-commit-config.yaml        # Pre-commit hooks configuration
├── .tflint.hcl                    # TFLint configuration
├── .tfsec.yml                     # TFSec configuration
├── .gitignore                     # Git ignore rules
└── README.md                      # Project documentation
```

Each environment directory contains:
- `main.tf`: Main Terraform configuration
- `variables.tf`: Input variables definition
- `outputs.tf`: Output values definition
- `versions.tf`: Provider and Terraform version constraints

Each module directory contains:
- `main.tf`: Module resources
- `variables.tf`: Module input variables
- `outputs.tf`: Module outputs
- `versions.tf`: Module version constraints

## Infrastructure Scanning

This template includes several infrastructure scanning tools to ensure code quality and security:

### Pre-commit Hooks

The repository uses pre-commit hooks to automatically check code quality before commits:

```bash
# Install pre-commit
pip install pre-commit

# Install the hooks
pre-commit install
```

The following checks are performed:
- Terraform formatting
- Terraform validation
- Terraform documentation
- TFLint checks
- TFSec security scanning
- Checkov compliance checks

### Scanning Tools

1. **TFLint**
   - Lints Terraform code
   - Checks for best practices
   - Provider-specific rules

2. **TFSec**
   - Security scanning
   - Misconfiguration detection
   - Compliance checking

3. **Checkov**
   - Infrastructure as Code scanning
   - Security and compliance
   - Custom policy support

### GitOps Workflow

1. All infrastructure changes are made through pull requests
2. Changes are first applied to the dev environment
3. After validation, changes are promoted to staging
4. Finally, changes are promoted to production
5. Each environment has its own state file and configuration

### Getting Started

1. Clone this repository
2. Copy the template to your new project
3. Update the environment-specific variables in each environment directory
4. Initialize Terraform in your target environment:
   ```bash
   cd environments/dev
   terraform init
   ```

### Environment Promotion

To promote changes between environments:

1. Create a pull request from dev to staging
2. After approval and successful deployment to staging
3. Create a pull request from staging to production
4. Follow the same process for production deployment

### Security

- Each environment uses separate state files
- Sensitive variables are stored in a secure vault
- Access to production requires additional approvals
- Automated security scanning in CI/CD pipeline

### Contributing

1. Create a feature branch from dev
2. Make your changes
3. Run pre-commit hooks:
   ```bash
   pre-commit run --all-files
   ```
4. Create a pull request
5. Wait for review and approval
6. Merge to dev and follow the promotion process

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Workflow Process

The following diagram illustrates the workflow process:

```mermaid
graph TD
    A[Pull Request] --> B{Validation}
    B -->|Pass| C[Main Branch]
    B -->|Fail| D[Fix Issues]
    D --> A

    C --> E[Dev Environment]
    E -->|Auto| F[Staging Environment]
    F -->|Auto| G[Production Environment]

    H[Manual Trigger] -->|Dev| E
    H -->|Staging| F
    H -->|Production| G

    E --> I{Approval}
    F --> J{Approval}
    G --> K{Approval}

    I -->|Approved| F
    J -->|Approved| G
    K -->|Approved| L[Deploy]
```
