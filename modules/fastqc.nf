/************************************************************************
* FastQC
************************************************************************/
process fastqc {
    label 'fastqc'
    if (!workflow.profile.contains('node')) { label 'smallTask' }
    tag "$meta.sample"

    // publish the per-FASTQ HTML reports (raw and trimmed reads share this process, tell them apart by name)
    if ( params.softlink_results ) { publishDir "${params.output}/${params.fastqc_dir}", pattern: "*_fastqc.html", saveAs: { fn -> fn.contains('.trimmed_fastqc') ? "trimmed/${fn}" : "raw/${fn}" } }
    else { publishDir "${params.output}/${params.fastqc_dir}", mode: 'copy', pattern: "*_fastqc.html", saveAs: { fn -> fn.contains('.trimmed_fastqc') ? "trimmed/${fn}" : "raw/${fn}" } }

    input:
    tuple val(meta), path(reads) 

    output:
    path("*_fastqc.zip", emit: zip)
    path("*_fastqc.html", emit: html)

    script:
    """
    fastqc --noextract -t ${task.cpus} ${reads}
    """
}
