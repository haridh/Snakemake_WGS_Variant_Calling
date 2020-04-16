import pandas as pd
from snakemake.utils import validate
Stable = pd.read_table("samples.tsv")
validate(Stable, schema="schemas/sample_file.schema.yaml")
SAMPLES=Stable["samples"]
Single_Stable = Stable[Stable["fq2"].isna()]
Paired_Stable = Stable[Stable["fq2"].notna()]
single_end_samples = Single_Stable["samples"]
paired_end_samples = Paired_Stable["samples"]
basename=list(set(Stable["basename"]))
configfile: "config.yaml"
validate(config, schema="schemas/config.schema.yaml")
Path=config["Path"]["Path"]
ref=config["ref"]["fasta"]
rule all:
    input:
        expand("**insert_path**/{samples}.sort.dup.bqsr.bam", samples=SAMPLES),
        expand("**insert_path**/Mutect/{basename}.mutect.vcf", basename=basename),

include: "rules/bwa_align.smk"
include: "rules/Mark_duplicates.smk"
include: "rules/BQSR_recal_table.smk"
include: "rules/BQSR_apply.smk"
include: "rules/Mutect2_Call.smk"
