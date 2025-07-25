variable "tools" {
  default = {

    github-runner = {
      instance_type = "t3.small"
      policy_name = [
        "AdministratorAccess"
      ]
    }
    vault = {
      instance_type = "t3.small"
      policy_name = []
    }

  }
}

variable "hosted_zone_id" {
  default = "Z01638642TSP1K9JOJ8E9"
}
