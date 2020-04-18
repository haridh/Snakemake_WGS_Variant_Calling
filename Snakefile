import pandas as pd
from snakemake.utils import validate
Stable = pd.read_table("samples.tsv")
validate(Stable, schema="schemas/sample_file.schema.yaml")
SAMPLES=Stable["samples"]
basename=list(set(Stable["basename"]))
configfile: "config.yaml"
validate(config, schema="schemas/config.schema.yaml")
Path=config["Path"]["Path"]
ref=config["ref"]["fasta"]
rule all:
    input:
        expand("{Path}/BQSR/{samples}.sort.dup.bqsr.bam", Path=Path, samples=SAMPLES),
        expand("{Path}/Mutect/{basename}.mutect.vcf", Path=Path, basename=basename),
	expand("{Path}/Lofreq/{basename}/lofreq_somatic_final.snvs.vcf.gz", Path=Path, basename=basename)
include: "rules/Lofreq_call.smk"
include: "rules/Mutect2_Call.smk"
include: "rules/BQSR_apply.smk"
include: "rules/BQSR_recal_table.smk"
include: "rules/Mark_duplicates.smk"
include: "rules/bwa_align.smk"
