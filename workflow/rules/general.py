import glob

import pandas as pd
from snakemake.remote import FTP
from snakemake.utils import validate

ftp = FTP.RemoteProvider()

##### config file #####

validate(config, schema="../schemas/config.schema.yaml")

##### sample sheets #####

samples = pd.read_csv(config["samples"], sep="\t").set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

units = pd.read_csv(config["units"], dtype=str, sep="\t").set_index( # what indexing doing is just adding the variables as row names
    ["sample", "sequencing_type", "unit"], drop=False
)
validate(units, schema="../schemas/units.schema.yaml")

contigs = [c for c in range(1, 23)]
contigs.extend(["X", "Y"])