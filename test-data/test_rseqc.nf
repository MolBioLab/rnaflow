#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Test script for RSeQC module
// This script tests the RSeQC module with test data

// Include RSeQC module
include {rseqc_infer_experiment; rseqc_junction_annotation; rseqc_read_distribution; rseqc_gene_body_coverage; rseqc_inner_distance; rseqc_read_duplication; rseqc_bam_stat} from './modules/rseqc'

// Test data
test_bam = Channel.fromPath("test-data/test.bam", checkIfExists: false)
test_annotation = Channel.fromPath("test-data/test.gtf", checkIfExists: false)

// Test metadata
test_meta = [sample: "test_sample", paired_end: true, strandedness: "1"]

workflow test_rseqc {
    take:
        bam_ch
        annotation_ch
    
    main:
        // Create test data if not exists
        if (!bam_ch.toList().get(0).exists()) {
            println "Creating test BAM file..."
            // This would create a minimal test BAM file
        }
        
        if (!annotation_ch.toList().get(0).exists()) {
            println "Creating test GTF file..."
            // This would create a minimal test GTF file
        }
        
        // Test RSeQC processes
        rseqc_infer_experiment(Channel.of([test_meta, bam_ch.toList().get(0)]), annotation_ch)
        rseqc_junction_annotation(Channel.of([test_meta, bam_ch.toList().get(0)]), annotation_ch)
        rseqc_read_distribution(Channel.of([test_meta, bam_ch.toList().get(0)]), annotation_ch)
        rseqc_gene_body_coverage(Channel.of([test_meta, bam_ch.toList().get(0)]), annotation_ch)
        rseqc_read_duplication(Channel.of([test_meta, bam_ch.toList().get(0)]))
        rseqc_bam_stat(Channel.of([test_meta, bam_ch.toList().get(0)]))
        
        // Test paired-end specific process
        rseqc_inner_distance(Channel.of([test_meta, bam_ch.toList().get(0)]), annotation_ch)
    
    emit:
        infer_experiment = rseqc_infer_experiment.out.infer_experiment
        junction_annotation = rseqc_junction_annotation.out.junction_annotation
        read_distribution = rseqc_read_distribution.out.read_distribution
        gene_body_coverage = rseqc_gene_body_coverage.out.gene_body_coverage
        inner_distance = rseqc_inner_distance.out.inner_distance
        read_duplication = rseqc_read_duplication.out.read_duplication
        bam_stat = rseqc_bam_stat.out.bam_stat
}

workflow {
    test_rseqc(test_bam, test_annotation)
} 