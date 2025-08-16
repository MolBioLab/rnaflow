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

process rseqc_inner_distance {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}/inner_distance", pattern: "*.pdf,*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}/inner_distance", mode: 'copy', pattern: "*.pdf,*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta), path("${meta.sample}.inner_distance.pdf"), path("${meta.sample}.inner_distance.txt"), emit: inner_distance

    script:
    """
    inner_distance.py -i ${bam} -o ${meta.sample}.inner_distance -r ${annotation}
    """
}

process rseqc_junction_annotation {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}/junction_annotation", pattern: "*.pdf,*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}/junction_annotation", mode: 'copy', pattern: "*.pdf,*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta), path("${meta.sample}.junction_annotation.pdf"), path("${meta.sample}.junction_annotation.txt"), emit: junction_annotation

    script:
    """
    junction_annotation.py -i ${bam} -o ${meta.sample}.junction_annotation -r ${annotation}
    """
}

process rseqc_read_distribution {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}/read_distribution", pattern: "*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}/read_distribution", mode: 'copy', pattern: "*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta), path("${meta.sample}.read_distribution.txt"), emit: read_distribution

    script:
    """
    read_distribution.py -i ${bam} -r ${annotation} > ${meta.sample}.read_distribution.txt
    """
}

process rseqc_gene_body_coverage {
    label 'rseqc'
    tag "$meta.sample"
    
    if ( params.softlink_results ) { publishDir "${params.output}/${params.rseqc_dir}/gene_body_coverage", pattern: "*.pdf,*.txt" }
    else { publishDir "${params.output}/${params.rseqc_dir}/gene_body_coverage", mode: 'copy', pattern: "*.pdf,*.txt" }

    input:
    tuple val(meta), path(bam)
    path(annotation)

    output:
    tuple val(meta), path("${meta.sample}.geneBodyCoverage.pdf"), path("${meta.sample}.geneBodyCoverage.txt"), emit: gene_body_coverage

    script:
    """
    geneBody_coverage.py -i ${bam} -o ${meta.sample}.geneBodyCoverage -r ${annotation}
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