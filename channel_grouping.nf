nextflow.enable.dsl = 2

process make_files {
    output:
    file "file*.txt"

    """
    for i in \$(seq 3 ); do 
        for j in \$(seq 3 ); do 
            touch file_\${i}_s_\${j}.txt
        done
    done
    """
}

process grouped_files {
    echo true

    input:
    file grouped_files

    """echo 'I have grouped files: ${grouped_files}'"""
}

workflow {
    make_files()
    grouped_files(
        // Label the files with their prefix
        make_files.out.flatten().map{ it -> [it.baseName.split("_s_")[0], it ] }.view().\
        // Group the files by this prefix
        groupTuple().map { it -> it[1] })
}