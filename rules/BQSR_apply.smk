rule Apply_BQSR:
    input:
        inbam="{Path}/mapped_reads/{sample}.sort.dup.bam",
        ref_fasta=config["ref"]["fasta"],
        recal="{Path}/BQSR/{sample}.bqsr.recal.table"
    output:
        outbam="{Path}/BQSR/{sample}.sort.dup.bqsr.bam"
    threads: 48
    shell:
        "gatk ApplyBQSR -I {input.inbam} -R {input.ref_fasta} --bqsr-recal-file {input.recal} -O {output.outbam}"
