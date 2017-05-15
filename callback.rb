f = PyCall.wrap_ruby_callable(proc { p 42 })
PyCall.eval(<<PYTHON, input_type: :file)
def call_function(f):
  x = f()
  print(x)
  return x
PYTHON
cf = PyCall.eval('call_function')
p res: cf.(f)
p PyCall.const_get(:GCGuard).instance_eval { @gc_guard }
PyCall::LibPython.Py_DecRef(f)
f = nil
p PyCall.const_get(:GCGuard).instance_eval { @gc_guard }
