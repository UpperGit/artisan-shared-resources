dependency "root_zone" {
  config_path = "../root-zone"
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//dns/records"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  records = [

    {
      type = "TXT"
      ttl  = 60
      record_set = [
        "My\"\"sample record",
      ]
    }

  ]

}
