#!/usr/bin/env bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

_createBaseProject() {
  cat > ${BUILD_DIR}/build.boot <<EOF
(set-env! :source-paths   #{"src"}
          :resource-paths #{"resources" "config"}
          :dependencies   '[[org.clojure/clojure "1.7.0"]])
(def version "0.0.1")
(task-options! pom {:project 'sample
                    :version version})
(deftask build
  "Build my project."
  []
  (comp (aot :namespace '#{sample})
        (pom)
        (uber)
        (jar :main 'sample)))
EOF

  mkdir -p ${BUILD_DIR}/src/sample

  cat > ${BUILD_DIR}/src/sample/core.clj <<EOF
(ns sample.core
  (:gen-class))
(defn -main [& args]
  (println "Welcome to my project! These are your args:" args))
EOF
}

#### Tests

test_compile() {
  _createBaseProject
  compile
  assertCapturedSuccess
  assertCaptured "Downloading boot"
  assertCaptured "BOOT_VERSION=2.2.0"
  assertCaptured "Adding uberjar entries"
  assertCaptured "Running: boot build"
  assertCaptured "Writing sample-0.0.1.jar"
}
