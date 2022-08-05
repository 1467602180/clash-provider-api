package main

import (
    "dagger.io/dagger"

		"dagger.io/dagger/core"
    "universe.dagger.io/go"
    "universe.dagger.io/git"
)

dagger.#Plan & {
    client: filesystem: "./build": write: contents: actions.build.buildGo.output

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
    		fetch: git.#Pull & {
				remote: "https://github.com/1467602180/clash-provider-api.git"
				ref: "master"
			}

    		buildGo:go.#Build & {
            source: actions.source.output
      }
    	}
    }

}
