gitacp() {
    # Check if a commit message was actually provided
    if [ -z "$1" ]; then
        echo "Error: You must provide a commit message."
        echo "Usage: gitacp \"your message here\""
        return 1
    fi

    git add . && \
    git commit -m "$1" && \
    git push
}

repoupdate() {
    # This function is to be used in a parent folder of a bunch of repos
    echo "Warning: This script will automatically perform git pulls"
    
    # Iterate through every item in the current directory
    for d in */ ; do
        # Check if the subdirectory contains a .git folder
        if [ -d "$d/.git" ]; then
            echo "Updating $d..."
    
            # Move into the directory, pull, and return back
            (cd "$d" && git pull)
        else
            echo "Skipping $d (not a git repo)"
        fi
    done

    echo "Everything should be up to date!"
}

log-cleaner() {
    tail -n 10  /mnt/usfnas13/_SystemAnalystDocs/_OutgoingData/courses/log.txt > log.tmp && mv log.tmp /mnt/usfnas13/_SystemAnalystDocs/_OutgoingData/courses/log.txt
}

# Add this to your shell config
browse_docs() {
    # This assumes docsets are installed via Zeal
    # You can list docsets or search directly
    local query=$(zeal --list-docsets | fzf --prompt="Select Docset > ")
    [ -n "$query" ] && zeal "$query:" &
}
