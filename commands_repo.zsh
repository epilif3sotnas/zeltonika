add_origin() {
    gremote add origin git@github.com:epilif3sotnas/[PROJECT_NAME].git
}

merge() {
    gmb origin/main --allow-unrelated-histories
}