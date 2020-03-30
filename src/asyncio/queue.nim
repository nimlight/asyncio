type
  CircularQueue*[Capacity: static[int], T] = object
    data: array[Capacity, T]
    head, tail: int

proc initCircularQueue*[Capacity: static[int], T](): CircularQueue[Capacity, T] =
  discard

func isFull*(q: CircularQueue): bool {.inline.} =
  abs(q.tail-q.head) == q.Capacity

func isEmpty*(q: CircularQueue): bool {.inline.} =
  q.tail == q.head

proc deQueue*[Capacity: static[int], T](q: var CircularQueue[Capacity, T]): owned T =
  if q.isEmpty:
    return
  if q.head < q.Capacity:
    result = move q.data[q.head]
  else:
    result = move q.data[q.head-q.Capacity]
  inc(q.head)
  if q.head == 2 * q.Capacity:
    q.head = 0

proc peekQueue*[Capacity: static[int], T](q: CircularQueue[Capacity, T]): lent T =
  if q.isEmpty:
    return
  if q.head < q.Capacity:
    result = q.data[q.head]
  else:
    result = q.data[q.head-q.Capacity]

proc enQueue*[Capacity: static[int], T](q: var CircularQueue[Capacity, T], v: sink T) =
  if q.isFull:
    return
  if q.tail < q.Capacity:
    q.data[q.tail] = v
  else:
    q.data[q.tail-q.Capacity] = v
  inc(q.tail)
  if q.tail == 2 * q.Capacity:
    q.tail = 0

func len*(q: CircularQueue): int {.inline.} =
  result = q.tail - q.head
  while result < 0:
    result.inc(q.Capacity)


when isMainModule:
  var c = initCircularQueue[10, int]()
  for i in 1 .. 10:
    c.enQueue(i)
  for i in 1 .. 10:
    discard c.deQueue
  for i in 1 .. 10:
    c.enQueue(i)
  for i in 1 .. 8:
    discard c.deQueue

  echo c.peekQueue
  echo c.deQueue
  echo c.data
  echo c.len
