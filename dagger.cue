package main

import (
    "dagger.io/dagger"

		"dagger.io/dagger/core"
    "universe.dagger.io/go"
)

dagger.#Plan & {
    client: filesystem: {
    	"./build": write:contents: actions.build.build.output
    }

    actions: {

    	source: core.#Source & {
				path: "."
				exclude: [
					"node_modules",
					"build",
					"*.cue",
					"*.md",
					".git",
				]
			}

    	build: {

    		build:go.#Build & {
            source: actions.source.output
            env: {
            		GOOS: "linux"
								GOARCH: "386"
            }
      }
    	}
    }

}
