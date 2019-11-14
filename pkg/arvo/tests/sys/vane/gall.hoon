/+  *test
::
/=  gall-raw  /:  /===/sys/vane/mall  /!noun/
::
=/  test-pit=vase  !>(..zuse)
=/  gall-gate  (gall-raw test-pit)
::
|%
::  +test-init: test %init
::
++  test-init
  ^-  tang
  ::
  =/  time  ~1111.1.1
  ::
  =/  call-args
    =/  =duct  ~[/init]
    =/  =type  -:!>(*task:able:mall)
    =/  =task:able:mall  [%init ~nec]
    [duct type task]
  ::
  =/  expected-moves  ~
  ::
  =^  results  gall-gate
    (gall-call gall-gate time *sley call-args expected-moves)
  ::
  results
::  +test-conf: test %conf
::
++  test-conf
  ^-  tang
  ::
  =/  =duct  ~[/init]
  =/  time  (add ~1111.1.1 ~s1)
  =/  =term  %my-agent
  =/  ship  ~nec
  ::
  =/  call-args
    =/  =type  -:!>(*task:able:mall)
    =/  =task:able:mall
      =/  =dock  [ship term]
      [%conf dock dock]
    [duct type task]
  ::
  =/  =move:gall-gate
    =/  =path  /sys/core/[term]/(scot %p ship)/[term]/(scot %da time)
    =/  =note-arvo
      =/  =schematic:ford  [%core [ship term] /hoon/[term]/age]
      =/  =task:able:ford  [%build %.y schematic]
      [%f task]
    [duct %pass path note-arvo]
  ::
  =/  expected-moves=(list move:gall-gate)  ~[move]
  ::
  =^  results  gall-gate
    (gall-call gall-gate time *sley call-args expected-moves)
  ::
  results
::  +gall-call: have %gall run a +task and assert it produces expected-moves
::
++  gall-call
  |=  $:  gall-gate=_gall-gate
          now=@da
          scry=sley
          call-args=[=duct =type wrapped-task=(hobo task:able:mall)]
          expected-moves=(list move:gall-gate)
      ==
  ^-  [tang _gall-gate]
  ::
  =/  gall-core  (gall-gate our=~nec now=now eny=`@`0xdead.beef scry=scry)
  ::
  =^  moves  gall-gate  (call:gall-core call-args)
  ::
  =/  output=tang
    %+  expect-eq
      !>  expected-moves
      !>  moves
  ::
  [output gall-gate]
--
