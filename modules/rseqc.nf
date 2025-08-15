/************************************************************************
* RSeQC - RNA-Seq Quality Control
* Provides various quality control metrics for RNA-Seq data
************************************************************************/

process rseqc_infer_experiment {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta.sample), path("${meta.sample}.infer_experiment.txt"), emit: infer_experiment

    script:
    """
    infer_experiment.py -r ${annotation} -i ${bam} > ${meta.sample}.infer_experiment.txt
    """
}

process rseqc_junction_annotation {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta.sample), path("${meta.sample}.junction_annotation.txt"), emit: junction_annotation

    script:
    """
    junction_annotation.py -r ${annotation} -i ${bam} -o ${meta.sample}.junction_annotation
    """
}

process rseqc_read_distribution {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta.sample), path("${meta.sample}.read_distribution.txt"), emit: read_distribution

    script:
    """
    read_distribution.py -r ${annotation} -i ${bam} > ${meta.sample}.read_distribution.txt
    """
}

process rseqc_gene_body_coverage {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt,*.pdf" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt,*.pdf" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta.sample), path("${meta.sample}.geneBodyCoverage.txt"), path("${meta.sample}.geneBodyCoverage.pdf"), emit: gene_body_coverage

    script:
    """
    geneBody_coverage.py -r ${annotation} -i ${bam} -o ${meta.sample}.geneBodyCoverage
    """
}

process rseqc_inner_distance {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt,*.pdf" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt,*.pdf" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta.sample), path("${meta.sample}.inner_distance.txt"), path("${meta.sample}.inner_distance.pdf"), emit: inner_distance

    script:
    """
    inner_distance.py -r ${annotation} -i ${bam} -o ${meta.sample}.inner_distance
    """
}

process rseqc_read_duplication {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt,*.pdf" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt,*.pdf" }

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta.sample), path("${meta.sample}.read_duplication.txt"), path("${meta.sample}.read_duplication.pdf"), emit: read_duplication

    script:
    """
    read_duplication.py -i ${bam} -o ${meta.sample}.read_duplication
    """
}

process rseqc_bam_stat {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}", pattern: "*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}", mode: 'copy', pattern: "*.txt" }

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta.sample), path("${meta.sample}.bam_stat.txt"), emit: bam_stat

    script:
    """
    bam_stat.py -i ${bam} > ${meta.sample}.bam_stat.txt
    """
} 