ref_genome_path = "/Volumes/omid_drive/cancer_project/ref_genome/GRCh38.d1.vd1.fa"
gatk ="/Users/omidalam/Documents/6_sarbaazi/tools/gatk/gatk"

rule mutect2:
    input:
        normal= "/Volumes/omid_drive/cancer_project/ref_dataset/{sample}_N_1_chr1.bwa.dedup.bam",
        tumor= "/Volumes/omid_drive/cancer_project/ref_dataset/{sample}_T_1_chr1.bwa.dedup.bam"
    output: "{sample}_snv.vcf.gz"
    params: normal_name= "WGS_NS_N_1"
    conda:
        "can_vac"
    shell:
        "{gatk} Mutect2 -I {input.tumor} -I {input.normal} -R {ref_genome_path} -normal {params.normal_name} -O {output}"

        #gatk Mutect2 -I /Volumes/omid_drive/cancer_project/ref_dataset/WGS_NS_T_1.bwa.dedup.bam -I /Volumes/omid_drive/cancer_project/ref_dataset/WGS_NS_N_1.bwa.dedup.bam -R /Volumes/omid_drive/cancer_project/ref_genome/GRCh38.d1.vd1.fa -normal WGS_NS_N_1 -O WGS_NS_snv.vcf.gz -RF MateDifferentStrandReadFilter -RF MateDistantReadFilter -RF MateOnSameContigOrNoMappedMateReadFilter