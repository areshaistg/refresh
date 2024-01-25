sourcemap: sourcemap.json
	rojo sourcemap .\test.project.json > sourcemap.json

clean:
	rm sourcemap.json
