rule BQSR_recal_table:
    input:
        inbam="{Path}/mapped_reads/{sample}.sort.dup.bam",
        ref_fasta=config["ref"]["fasta"],
        known_sites=config["ref"]["known_sites"]
    output:
        outrecal="{Path}/BQSR/{sample}.bqsr.recal.table"
    threads: 48
    shell:
        "gatk BaseRecalibrator -I {input.inbam} -R {input.ref_fasta} -O {output.outrecal} --known-sites {input.known_sites}"
