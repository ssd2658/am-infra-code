# Multi-Cloud Terraform Infrastructure

## Overview
This Terraform configuration supports deploying Kubernetes clusters and PostgreSQL databases across multiple cloud providers.

## Supported Cloud Providers
- Google Cloud Platform (GCP)
- Microsoft Azure

## Prerequisites
- Terraform
- Cloud Provider CLI
  - Google Cloud SDK (for GCP)
  - Azure CLI (for Azure)
- Docker Compose (optional)

## Configuration

### 1. Choose Cloud Provider
Edit `terraform.tfvars`:
```hcl
cloud_provider = "gcp"  # or "azure"
```

### 2. Set Credentials
- GCP: `gcloud auth application-default login`
- Azure: `az login`

### 3. Configure Variables
Copy `terraform.tfvars.example` to `terraform.tfvars` and customize:
```hcl
project_id     = "your-project-id"
region         = "us-central1"
cluster_name   = "my-cluster"
database_name  = "my-database"
```

## Deployment

### Using Terraform Directly
```bash
# Initialize
terraform init

# Plan
terraform plan

# Apply
terraform apply
```

### Using Docker Compose
```bash
# Initialize
docker-compose run --rm terraform init

# Plan
docker-compose run --rm terraform plan

# Apply
docker-compose run --rm terraform apply
```

## Docker Compose Development Environment

### Services
- `terraform`: Terraform CLI with cloud provider credentials
- `cloud-tools`: Additional cloud provider CLIs (gcloud, Azure CLI)
- `code-server`: Optional VSCode-like web IDE

### Prerequisites
- Docker
- Docker Compose
- Cloud Provider Credentials
  - GCP: `gcloud auth application-default login`
  - Azure: `az login`

### Usage

#### Start Development Environment
```bash
# Start all services
docker-compose up -d

# Start specific service
docker-compose up terraform
```

#### Terraform Commands
```bash
# Run Terraform in container
docker-compose run --rm terraform init
docker-compose run --rm terraform plan
docker-compose run --rm terraform apply
```

#### Access Cloud Tools
```bash
# Enter Terraform container
docker-compose exec terraform bash

# Run gcloud commands
docker-compose exec cloud-tools gcloud ...

# Run Azure CLI commands
docker-compose exec cloud-tools az ...
docker-compose down

# Stop and remove containers with volumes
docker-compose down -v
```

### Security Notes
- Never commit credential files
- Use strong, unique passwords
- Rotate credentials regularly

## Module Structure
- `modules/kubernetes/`
  - `gcp/`: GKE-specific configuration
  - `azure/`: AKS-specific configuration
- `modules/database/`
  - `gcp/`: Cloud SQL configuration
  - `azure/`: Azure PostgreSQL configuration

## Security Considerations
- Never commit `terraform.tfvars`
- Use strong, unique passwords
- Enable cloud provider security features
- Rotate credentials regularly

## Switching Cloud Providers
Simply change the `cloud_provider` variable in `terraform.tfvars`.

## GitHub Actions Workflow

### GitHub Actions Workflow Structure

#### Workflow Files
1. `common.yml`: Shared jobs and variable generation
2. `gcp-deployment.yml`: GCP-specific deployment workflow
3. `azure-deployment.yml`: Azure-specific deployment workflow

#### Workflow Triggers
- Push to `main` and `develop` branches
- Pull requests to `main` and `develop`
- Manual workflow dispatch

### Workflow Dispatch Inputs

#### Common Inputs
- `project_id`: Cloud project/subscription ID
- `region`: Deployment region
- `cluster_name`: Kubernetes cluster name
- `database_name`: Database instance name
- `environment`: Deployment environment (dev/preprod/prod)

#### Provider-Specific Defaults
- **GCP**:
  - Default Region: `us-central1`
  - Default Cluster: `portfolio-cluster`
- **Azure**:
  - Default Region: `eastus`
  - Default Cluster: `portfolio-cluster`

### Deployment Flow
1. Generate Terraform Variables
2. Authenticate with Cloud Provider
3. Initialize Terraform
4. Validate Configuration
5. Generate Terraform Plan
6. Apply Changes (on main branch)
7. Optional Slack Notification

### Secrets Management
- Use GitHub Secrets for sensitive information
- Provider-specific authentication secrets
- Database admin password
- Optional Slack webhook

### Workflow Selection
- Choose workflow based on target cloud provider
- Reusable common workflow for shared tasks
- Separate deployment logic for each provider

### Terraform Deployment Router

#### Workflow: `terraform.yml`

##### Deployment Options
- Single cloud provider deployment
- Multi-cloud deployment
- Automatic routing based on input

##### Deployment Modes
1. **Single Provider**
   - Select `gcp` or `azure`
   - Deploys to specified cloud
2. **Multi-Cloud**
   - Select `both`
   - Deploys to GCP and Azure simultaneously

##### Routing Mechanism
- Dynamic provider selection
- Uses matrix strategy for parallel deployments
- Fallback to default provider (GCP) for push events

#### Workflow Dispatch Inputs
- `cloud_provider`: gcp, azure, or both
- `project_id`: Cloud project identifier
- `region`: Deployment region
- `cluster_name`: Kubernetes cluster name
- `database_name`: Database instance name
- `environment`: dev, preprod, or prod

#### Deployment Flow
1. Determine providers to deploy
2. Trigger provider-specific workflows
3. Deploy infrastructure
4. Aggregate deployment status
5. Send notifications on failure

#### Example Scenarios
```yaml
# Deploy only to GCP
inputs:
  cloud_provider: gcp
  project_id: my-gcp-project

# Deploy to both providers
inputs:
  cloud_provider: both
  project_id: multi-cloud-project
```

### Best Practices
- Use secrets for sensitive information
- Leverage environment-specific configurations
- Monitor multi-cloud deployments carefully
