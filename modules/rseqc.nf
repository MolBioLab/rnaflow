/************************************************************************
* RSeQC - RNA-seq Quality Control
* Provides various quality control metrics for RNA-seq data
************************************************************************/

process rseqc_bam_stat {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}/bam_stat", pattern: "*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}/bam_stat", mode: 'copy', pattern: "*.txt" }

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta), path("${meta.sample}.bam_stat.txt"), emit: bam_stat

    script:
    """
    bam_stat.py -i ${bam} > ${meta.sample}.bam_stat.txt
    """
}

process rseqc_read_duplication {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}/read_duplication", pattern: "*.pdf,*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}/read_duplication", mode: 'copy', pattern: "*.pdf,*.txt" }

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta), path("${meta.sample}.DupRate.pdf"), path("${meta.sample}.DupRate.txt"), emit: read_duplication

    script:
    """
    read_duplication.py -i ${bam} -o ${meta.sample}.DupRate
    """
} 