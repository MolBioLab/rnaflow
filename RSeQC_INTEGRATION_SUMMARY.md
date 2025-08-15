# RSeQC Integration Summary

## Overview
Module RSeQC đã được tích hợp thành công vào pipeline rnaflow-1 để cung cấp các phân tích chất lượng RNA-seq toàn diện.

## Files Created/Modified

### 1. New Files Created:
- `modules/rseqc.nf` - Module chính chứa các process RSeQC
- `envs/rseqc.yaml` - Environment conda cho RSeQC
- `RSeQC_INTEGRATION_SUMMARY.md` - File tóm tắt này

### 2. Files Modified:

#### `nextflow.config`
- Thêm tham số `rseqc_dir = '06-RSeQC'` vào params
- Cập nhật thứ tự thư mục output (annotation_dir, deseq2_dir, assembly_dir, rnaseq_annotation_dir)

#### `configs/conda.config`
- Thêm cấu hình conda cho RSeQC: `withLabel: rseqc { conda = "$baseDir/envs/rseqc.yaml" }`

#### `configs/container.config`
- Thêm container cho RSeQC: `withLabel: rseqc { container = "biocontainers/rseqc:4.0.0--py_0" }`

#### `configs/nodes.config`
- Thêm cấu hình resource cho RSeQC: `withLabel: rseqc { cpus = 8 ; memory = '8 GB' }`

#### `configs/local.config`
- Thêm cấu hình local cho RSeQC: `withLabel: rseqc { cpus = params.cores }`

#### `main.nf`
- Thêm include cho module RSeQC
- Thêm workflow `rseqc_analysis`
- Tích hợp RSeQC vào workflow `expression_reference_based`
- Thêm `rseqc_dir` vào valid_params

#### `citations.md`
- Thêm citation cho RSeQC

## RSeQC Processes Included

Module RSeQC bao gồm các process sau:

1. **rseqc_bam_stat** - Thống kê BAM file
2. **rseqc_inner_distance** - Phân tích khoảng cách inner distance
3. **rseqc_junction_annotation** - Annotation của splice junctions
4. **rseqc_read_distribution** - Phân bố reads trên các vùng gene
5. **rseqc_gene_body_coverage** - Coverage dọc theo gene body
6. **rseqc_read_duplication** - Phân tích read duplication
7. **rseqc_tin** - Transcript Integrity Number

## Output Structure

Kết quả RSeQC sẽ được lưu trong thư mục `results/06-RSeQC/` với các thư mục con:
- `bam_stat/` - Thống kê BAM
- `inner_distance/` - Kết quả inner distance
- `junction_annotation/` - Annotation junctions
- `read_distribution/` - Phân bố reads
- `gene_body_coverage/` - Coverage gene body
- `read_duplication/` - Duplication analysis
- `tin/` - Transcript Integrity Number

## Usage

Module RSeQC sẽ tự động chạy trong quá trình phân tích gene expression (không phải assembly). Không cần thêm tham số nào, module sẽ được thực thi sau bước featureCounts.

## Dependencies

- RSeQC >= 4.0.0
- samtools >= 1.9
- bedtools >= 2.29.0

## Integration Points

- Chạy sau bước mapping (HISAT2/Minimap2) và indexing BAM
- Chạy sau bước featureCounts
- Chạy trước bước DESeq2
- Kết quả có thể được tích hợp vào MultiQC report

## Notes

- Module được thiết kế để hoạt động với cả Illumina và Nanopore reads
- Tất cả các process đều có label 'rseqc' để quản lý resource
- Kết quả được publish theo cấu hình softlink_results
- Module tương thích với tất cả các profile (conda, docker, singularity) 