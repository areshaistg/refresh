sourcemap: sourcemap.json
	rojo sourcemap .\test.project.json --output sourcemap.json
	wally-package-types --sourcemap .\sourcemap.json Packages
	wally-package-types --sourcemap .\sourcemap.json DevPackages

clean:
	rm sourcemap.json
