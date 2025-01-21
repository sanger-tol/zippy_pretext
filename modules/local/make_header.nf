process MAKE_HEADER {
    tag "$meta.id"
    label 'process_single'

    conda "conda-forge::coreutils=9.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    'https://depot.galaxyproject.org/singularity/ubuntu:20.04' :
    'docker.io/ubuntu:20.04' }"

    input:
    tuple val(meta), path(outlog)

    output:
    tuple val(meta), path("*header.txt")  , emit: header
    path "versions.yml"                 , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args    = task.ext.args     ?: ''
    def prefix  = task.ext.prefix   ?: "${meta.id}"

    """
    make_header.sh ${outlog} > ${prefix}_header.txt
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        make_header: \$(make_header.sh -v)
    END_VERSIONS
    """

    stub:
    def prefix  = args.ext.prefix   ?: "${meta.id}"
    """
    touch ${prefix}.pairs.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        make_header: \$(make_header.sh -v)
    END_VERSIONS
    """
}
