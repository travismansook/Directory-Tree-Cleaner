#!/bin/bash

# Non-recursive method.
queue[0]="$1" #queue array at 0 index is testdir
if [ $# -gt 1 ]; then
	echo "too many arguments"
elif [ $# -eq 1 ]; then
	queue[0]="$1" #queue array at 0 index is testdir
	files_processed=0
	zero_length=0
	if [ -d "${queue[@]}" ]; then
		echo "Target directory: ${queue[0]}"
		echo""
		while [ "${#queue[@]}" -ne 0 ]; do #if array is not empty then enter loop
		        #echo "${queue[0]}"
			
			if [ -f "${queue[0]}" ]; then
			#	echo "${queue[0]} is a regular file"
				files_processed=$(($files_processed+1))
				if [ ! -s "${queue[0]}" ]; then
					#echo "${queue[0]} is byte 0"
					zero_length=$(($zero_length+1))
					echo "Removed zero-length file: ${queue[0]}"
					rm ${queue[0]}
				fi
			fi


		        if [ -d "${queue[0]}" ] && [ $(ls "${queue[0]}" | wc -l) -ne 0 ]; then #while it is a directory and it is not empty enter the if condition
		                entries=("${queue[0]}"/*) #in entries array put everything inside put everything inside the testdir
		                # entries is all the contents of the testdir

		                # merge two arrays together
		       	        queue=("${queue[@]}" "${entries[@]}") # 2 arrays, one array as the directory that is being traversed, and another array as all the entries inside the testdir 
			fi
		        # remove the element at 0
		        queue=("${queue[@]:1}")
		done
		echo "" 
		echo "Traversal Complete."        
		echo "Total files processed: $files_processed"
                echo "Zero-length files removed: $zero_length"

	else
		echo "directory does not exist"
	fi

else

	queue[0]="." #queue array at 0 index is testdir

	files_processed=0
        zero_length=0
        if [ -d "${queue[@]}" ]; then
                echo "Target directory: ${queue[0]}"
                echo""
                while [ "${#queue[@]}" -ne 0 ]; do #if array is not empty then enter loop
                        #echo "${queue[0]}"

                        if [ -f "${queue[0]}" ]; then
                        #       echo "${queue[0]} is a regular file"
                                files_processed=$(($files_processed+1))
                                if [ ! -s "${queue[0]}" ]; then
                                        #echo "${queue[0]} is byte 0"
                                        zero_length=$(($zero_length+1))
                                        echo "Removed zero-length file: ${queue[0]}"
                                        rm ${queue[0]}
                                fi
                        fi


                        if [ -d "${queue[0]}" ] && [ $(ls "${queue[0]}" | wc -l) -ne 0 ]; then #while it is a directory and it is not empty enter the if condition
                                entries=("${queue[0]}"/*) #in entries array put everything inside put everything inside the testdir
                                # entries is all the contents of the testdir

                                # merge two arrays together
                                queue=("${queue[@]}" "${entries[@]}") # 2 arrays, one array as the directory that is being traversed, and another array as all the entries inside the testdir 
                        fi
                        # remove the element at 0
                        queue=("${queue[@]:1}")
                done
                echo "" 
                echo "Traversal Complete."        
                echo "Total files processed: $files_processed"
                echo "Zero-length files removed: $zero_length"

        else
                echo "directory does not exist"
        fi


fi
