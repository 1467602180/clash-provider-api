package main

import (
    "dagger.io/dagger"

		"dagger.io/dagger/core"
    "universe.dagger.io/go"
)

dagger.#Plan & {
    client: filesystem: "./build": write: contents: actions.build.output

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

    	build: go.#Build & {
            source: actions.source.output
      }
    }

}
