.PHONY: generate

generate:
	ghc ./generate.hs 


run: generate
	./generate | xmllint --format -


clean:
	-rm *.o *.hi generate

