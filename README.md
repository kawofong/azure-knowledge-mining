# Azure Knowledge Mining

Knowledge mining using Azure platform: Azure Search, key phrase extraction, sentiemnt analysis, entity recognition, optical character recognition, and image analysis.

## Getting Started

- Clone the repository

- In `./terraform`:
  - Change `prefix` in `variables.tf` because APG server name has to be globally unique
  - Run `terraform plan -out=out.tfplan`
  - Run `terraform apply out.tfplan`
  - Note the outputs of `terraform apply`

## Next Steps

- [] Terraform: Cog Service
- [] TF: Function
- [] ARM: Azure Search, Cog Service, Function
- [] Documentation
- [] Architectural diagram
- [] Change Azure AI Search pipeline field `urls` to `links`
- [] Custom Skillset

## Best Practices

- When productionizing the knowledge mining solution, please consider the following points:
  - Tag each resources with appropriately (e.g. billing center, environment, etc.)
  - Understand the limitation of each Azure resource SKU and consider which SKUs are appropriate for production workload

---

### PLEASE NOTE FOR THE ENTIRETY OF THIS REPOSITORY AND ALL ASSETS

1. No warranties or guarantees are made or implied.
2. All assets here are provided by me "as is". Use at your own risk. Validate before use.
3. I am not representing my employer with these assets, and my employer assumes no liability whatsoever, and will not provide support, for any use of these assets.
4. Use of the assets in this repo in your Azure environment may or will incur Azure usage and charges. You are completely responsible for monitoring and managing your Azure usage.

---

Unless otherwise noted, all assets here are authored by me. Feel free to examine, learn from, comment, and re-use (subject to the above) as needed and without intellectual property restrictions.

If anything here helps you, attribution and/or a quick note is much appreciated.
