Here=$(PWD)

Testdir=$(Here)/eg

Tmp=/tmp

ready:  $(Testdir) $(Tmp)

Tests:=$(shell cd $(Testdir); ls  | egrep '^[0-9]+$$' | sort -n  )

run : ready $(Testdir)/$(X)
	@echo $X 2>&1
	@cat $(Testdir)/$(X) | $(Run)

cache : ready
	@$(MAKE) -s run | tee $(Testdir)/$X.want
	@echo new test result cached to $(Testdir)/$X.want

test : ready $(Testdir)/$(X).want
	@$(MAKE) -s run > $(Tmp)/$X.got
	@if diff -s $(Tmp)/$X.got $(Testdir)/$X.want > /dev/null;  \
		then echo PASSED $X ; \
		else echo FAILED $X,  got $(Tmp)/$X.got; \
            diff $(Testdir)/$X.want $(Tmp)/$X.got; \
		fi

test-all:  
	@echo $(Tests)
	@$(foreach x, $(Tests), $(MAKE) -s X=$x test;)

cache-all :
	@echo Affected files: $(Tests)
	@echo If you are absolutely sure, use make cache-all-I-know-what-Im-doing

cache-all-I-know-what-Im-doing :
	@$(foreach x, $(Tests), $(MAKE) -s X=$x cache;)

score :
	@$(MAKE) -s test-all | cut -d\  -f 1 | egrep '(PASSED|FAILED)' | sort | uniq -c

Run= python3 $(1)
