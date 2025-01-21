process JUICERC {
    tag "$meta.id"
    label 'process_single'

    container 'quay.io/sanger-tol/juicerc:1.2-c1'

    input:
    tuple val(meta), path(hicmap) 
    path(agpfile)
    path(idxfile)

    output:
    tuple val(meta), path("*txt")  , emit: alignment
    path("juicercout.log")         , emit: outlog
    path "versions.yml"            , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args    = task.ext.args     ?: ''
    def prefix  = task.ext.prefix   ?: "${meta.id}"

    """
    juicerc.sh ${hicmap} ${agpfile} ${idxfile} > ${prefix}_alignment_sorted.txt 

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
		juicer: \$(juicer -h | grep 'Version'|sed 's/Version: //g')	
    END_VERSIONS
    """

    stub:
    def prefix  = args.ext.prefix   ?: "${meta.id}"
    """
    touch ${prefix}.tpf

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        juicer: \$(juicer -h | grep 'Version'|sed 's/Version: //g')
    END_VERSIONS
    """
}
