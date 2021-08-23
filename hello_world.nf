nextflow.enable.dsl = 2

params.message = "hello world"

process make_file {
    output:
    file "message.txt"

    """
    echo "${params.message}" > message.txt
    """
}

process echo_file {
    echo true

    input:
    file message_file

    """
    cat ${message_file}
    """
}

workflow {
    make_file()
    echo_file(make_file.out)
}