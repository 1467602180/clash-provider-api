package main

import (
    "dagger.io/dagger"

		"dagger.io/dagger/core"
    "universe.dagger.io/go"
    "universe.dagger.io/git"
)

dagger.#Plan & {
    client: filesystem: {
    	"./build": write:contents: actions.build.build.output
    	".": write: contents:actions.build.fetch.output
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
    		fetch: git.#Pull & {
				remote: "https://github.com/1467602180/clash-provider-api.git"
				ref: "master"
			}

    		build:go.#Build & {
            source: actions.source.output
            env: {
            		GOOS: "linux"
								GOARCH: "arm"
            }
      }
    	}
    }

}
