# terragrunt-google
Terragrunt template for Google Cloud Platform



.
├── terragrunt.hcl          
├── penrose                 # This is project name. you can replace to your project app name
│   ├── project.hcl         # Load project related configuration
│   ├── dev                 # The project dev environemnt folder
│   ├── staging             # The project staging environment folder
│   └── production          # The project production environment folder
│       ├── env.hcl         # This is the production environment variable configuration
│       ├── asia-east1      # The asia-east1 region data
│       └── us-west1        # The us-west1 region data
└── 
