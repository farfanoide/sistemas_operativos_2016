#Sistemas Operativos
##Primer Parcial Teórico

Nota: El objetivo no es la pregunta misma, sino los conceptos que ella involucra


1. Un thread no tiene program counter (PC) propio .
> Falso, Cada Thread tiene su PC tanto ULT como KLT

2. Un thread tiene un stack en modo usuario y uno en modo supervisor, propios.
> No siempre - Los KLT si tienen, los ULT no porque la libreria ejecuta en modo usuario. Los KLT tienen ambos stack y los administra el kernel. Los ULT tienen 1 solo stack kernel (el del proceso) y uno propio stack de usuario, es decir todos los ULT de un proceso comparten el mismo stack en modo kernel.

3. Un context switch entre threads, no requiere un context switch de registros
> Falso - Siempre hay cambio de registros, sean ULT o KLT. Los ULT cambiaran aquellos registros que se pueden tocar en modo usuario y los KLT, tienen libertad de cambiar todos o los necesario. Si el cambio es entre dos KLT del mismo proceso, quiza no cambien registros relacionados a la memoria, porque comparte el mismo espacio.

4. Un hilo creado por un proceso tendrá su propio contexto.
> Falso, el concepto de contexto esta asociado a proceso, no a un hilo. Todos los hilos se ejecutan en el contexto del proceso. 

5. Un hilo creado por un proceso se ejecutará en el espacio de direcciones de este último.
> Verdadero, todo hilo tiene su codigo en el espacio de direcciones de su proceso.

6. Un hilo es la unidad básica de uso de la CPU.
> Depende, si hay KLT, si es la unidad de ejecucion. Si el SO no soporta hilos, para el SO la unidad de uso de CPU es el proceso.

7. Un hilo es la unidad de propiedad de recursos. 
> Falso, es el proceso sin importar el tipo de hilo. (Recursos: archivo, memoria. Se refiere a los recursos que se le asignan a nivel de proceso no de hilo).

8. Dentro de un proceso, un hilo cuenta con un estado de ejecución.
> Verdadera

9. Hay un PCB por procesos y los hilos que el cree. 
> Falso, el PBC es del proceso.

10. Cuando un proceso se swapea, los hilos quedan en memoria en estado de espera.
> Falso, si un proceso se SWAPEA los hilos bajan con el proceso.

11. En la administración de los hilos a nivel de usuario, interviene el kernel.
> Falso

12. En los ULT, cada proceso se encarga de administrar sus hilos.
> Verdadero, La libreria de hilos dentro del proceso la administra.

13. La suspensión de un ULT, provoca la suspensión del proceso.
> Depende, aca hay que tener en cuenta si la libreria da la funcionalidad de suspender, no necesariamente el proceso tambien se suspenda. Ahora si la suspencion se da por una SysCall, se se suspenderia el proceso.

14. Los KLT, en un ambiente multiprocesador, pueden ejecutarse en distintos
procesadores.
> Verdadero, es una de las ventajas de usar KLT.

15. En los KLT, el context switch entre hilos, no provoca un cambio de modo.
> Falso, lo hace el kernel al context switch.

16. El kernel de Linux 2.4 no consideraba el concepto de thread. V o F
> Verdadero

17. La System Call clone() permitía compartir la tabla de archivos entre el proceso padre e hijo pero no el espacio de memoria. V o F
> Falso

18. El kernel de Linux 2.6 adopto el modelo POSIX, donde se utilizaba el modelo N:M. V o F
> Falso, es 1 a 1.

19. Solaris implementa el modelo:  **N:M**

20. En Solaris, cada ULT siempre tiene relacionado un LWP. V o F
> Falso, pero si cada KLT tiene relacionado un LWP

21. Supongamos que en Solaris existe un proceso con varios ULT y que tiene asociado un único LWP. Si uno de sus ULT realiza una operación de E/S:
> Ningún ULT podrá ejecutarse hasta que no finalice la E/S

22. 
23.  
24. 
25. En Solaris, un proceso que tiene relacionado un único LWP, podrá aprovechar el uso de múltiples procesadores. V o F
> Falso

26. En Solaris, existen tantos KLTs como procesadores tenga la computadora. V o F
> Falso

27. En Solaris, existen tantos LWPs como ULTs haya entre todos los procesos del sistema. V o F
> Falso

28. En Solaris, la biblioteca de threads en modo usuario planifica la ejecución de los KLT sobre los procesadores. V o F.
>  Falso

29. En Solaris, un UTL ligado a un LWP podrá ejecutar aplicaciones con requerimientos de Tiempo Real. V o F
> Verdadero

30. En Solaris, un ULT puede estar en estado “Sleeping” y el LWP asociado en estado “Blocked” V o F
>  Falso, si tiene asociado un LWP esta en estado activo.

31. En Solaris, todo LWP con estado “Running” tiene asociado un ULT en estado “Active”. V o F
>  Verdadero 

32. En Solaris, la información de los registros del procesador es almacenada en los ULT. V o F
> Falso

33. Supongamos que en Solaris tenemos un programa que almacena cada dato que ingresa un usuario en 7 archivos diferentes. Para garantizar el mayor paralelismo en la aplicación, deberíamos contar con:
> Un proceso con 7 ULTs y 7 LWPs

34. Windows implementa el modelo 1:1 para sus threads. V o F
> Verdadero a nivel de hilos es 1:1.

35. La utilización de Fibers en Windows permite implementar un modelo N:M. V o F.
> Verdadero, se aproxima a un N:M por la independencia que da la fibra en la planificacion en modo usuario.

36. Las Fibers en Windows son administradas por el Kernel. V o F
> Falso, se planifican en modo usuario.

37. Las Fibers en Windows son propiedad: Del proceso o Del Thread.
> Se crean dentro de los Threads aunque tambien estan dentro del proceso por transitividad

38. En Windows, el stack en modo Kernel es información del proceso. V o F
> Falso, como el modelo es 1:1 hay un klt por cada Thread.

39. En Windows, toda la información de un Thread es mantenida en el espacio de memoria del sistema. V o F
>  Falso, (Del sistema se refiere a Kernel) Recordar que hay varias estructuras que se usan para modelar Procesos/Threads y que hay datos que se mantienen en estructuras en modo Usuario.

40. En Windows, cada thread tiene su Working Set. V o F
> Falso, (working set = Conjunto de paginas en memoria). Es por proceso dado que la memoria es del proceso. 

41. La información de planificación de un Thread es mantenida por: **El Kernel** 
>  En Layer Kernel es el de mas bajo nivel y se relaciona con lo mas cercano a la CPU, entre ellos planificacion y sincronizacion. Se pasan el contro en modo usuario, se pueden planificar sin que se necesite el Kernel.

42. El Kernel de Windows planifica las Fibers. V o F
> Falso

43. En Windows, una operación de E/S realizada por un Thread bloqueara a todo el proceso. V o F
> Falso, el modelo 1:1 hace que no se bloquee el proceso ante una E/S.

44. En Windows, una operación de E/S realizada por una Fiber bloqueara al thread al que pertenece la misma. V o F
> Verdadero, porque la entidad de ejecucion es el Thread, por ende se bloquearia.

45. Basta que una de las 4 condiciones de deadlock se cumpla, para que haya deadlock. 
> Falso, se necesitan las 4.

46. La desventaja de usar algoritmos de prevención del deadlock, es que baja el grado de multiprogramación. 
> Falso, baja la productividad de la CPU en la ejecucion de los procesos.

47. En un esquema de una instancia por tipo de recurso, cuando se encuentra un ciclo en un grafo de alocacion de recursos, la asignación de los recursos solicitados:
> **Pone al sistema en estado inseguro.** (de hecho es un Deadlock).   
> La multiprogramacion es la cantidad de procesos en memoria.

48. Todos los estados inseguros son deadlock.
> Falso

49. El algoritmo del Banquero sirve para sistemas con múltiples instancias de cada recurso.
> Verdadero 

50. Siempre que el grafo de recursos tiene ciclos, hay deadlock.
> Falso

51. Un buffer compartido entre dos procesos es una sección crítica.
> Verdadero

52. En el modelo productor-consumidor, el buffer compartido es una sección crítica.
> Verdadero 

53. En un programa solo puede haber una sección crítica. 
> Falso

54. Para ser una solución al problema de la sección críticas se deben cumplir 3 requerimientos: E. Mutua, progreso y espera limitada.

55. A la variable semáforo sólo puede accederse a través de sus operaciones.
> Verdadero

56. El signal del semáforo siempre afecta al semáforo.
> Verdadero

57. La secuencia para el uso de un recurso es solicitud, uso y **LIBERACION**

58. Semáforos es una herramienta útil para el problema de la sección crítica, pero no sirve para sincronización.
> Falso  

59. Semáforos se implementa a través de primitivas que aporta el SO.
> Falso (Del Hardware)

60. El proceso en espera, usando semáforos, puede usar busy waiting, colocándose en una cola asociada al semáforo.
> Re falso (Mezcla conceptos) 

61. La instrucción test-and-set se ejecuta atómicamente, no así la instrucción swap.
>  Falsa, ambas tienen la semantica de ser atomicas.

62. Con pasajes de mensajes es posible comunicar y sincronizar procesos.
> Verdadero

63. Los mensajes de IPC deben tener tamaño fijo
> No necesariamente.

64. Con pasajes de mensajes, en la comunicación directa, el proceso que quiere comunicarse debe nombrar explícitamente al receptor o al emisor.
> Verdadero

65. Con pasajes de mensajes, en la comunicación asimétrica, sólo el emisor nombra al receptor.
> Verdadero

66. Con pasajes de mensajes, en la comunicación indirecta el mensaje se envía a un buzón o puerto.
> Verdadero

67. En la comunicación indirecta, el propietario del buzón es el proceso que recibe.
> Verdadero

68. El usuario del buzón es quien envía.
> Verdadero

69. Cuando el propietario del buzón termina, el buzón desaparece.
> Verdadero

70. Con pasajes de mensajes, en sincronización, el envío con bloqueo es llamado asíncrono.
> Falso

71. El uso de mailbox es solamente para comunicación uno a uno de procesos.
> Falso

72. En ambientes multiprocesador es mejor implementar una solución a la sección critica usando: **Spinlock**
> a. Elevar el nivel de procesador   
> b. usar spinlock <--

73. Qué pasa con las interrupciones de menor nivel cuando se eleva el nivel de procesador?
> Son ignoradas, por eso es importante siempre estar en un nivel bajo 

74. Tengo tantos spinlocks como estructuras a compartir.
> Falso, no es tan asi, depende de como se organicen las estructuras.

75. Que ocurre si cuando se eleva el nivel del procesador, el módulo que se esté ejecutando genera un page fault?
> Si se esta en un nivel mayor al que se usa para resolver los page fault, fue el sistema. (Las estructuras que se sincronizan del kernel se ponen en areas que no se paginan, por ende jamas ocurriria un page fault)

76. Usar una variable cont, que voy incrementado o decrementando para implementar el modelo prod/cons... puede generar una race condition?
> Si, si no se usan de forma atomica.

77. La técnica de inhabilitar las interrupciones es óptima para el uso de procesos de usuario.
> Falso. Jamas debemos dar a un proceso la posibilidad de elevar el nivel de interrupcion.

78. La utilización de spinlocks es óptima para el uso de procesos de usuario.
> Falso, seria desperdicio de CPU en modo usuario.

79. En Unix System V, los objetos IPC creados son propiedad: **KERNEL**
> a. Kernel <--  
> b. Cada proceso que los crea.  

80. En Unix System V, en envio de mensajes es siempre bloqueante.
> Falso, se puede especificar.

81. En Unix System V, la recepción de mensajes es siempre bloqueante.
>  Falso, se puede especificar si queremos que se bloquee si esta vacio o nos devuelva un error.

82. En Unix System V, un proceso debe tener permisos de WRITE sobre una cola de
mensajes para: **Enviar**
> a. Enviar <--  
> b. Recibir   
> c. Ambos  

83. En Unix System V, una región de memoria compartida deberá encontrarse en la misma dirección en todos los espacios de memoria de los procesos que la utilizan.
> Falso.

84. En multiprocesadores, en la organización maestro esclavo, una syscall puede ser atendida en cualquiera de los procesadores.
> Falso 

85. En multiprocesadores, si cada CPU tiene su SO es posible que una CPU este saturada y otras sin trabajo productivo.
> Verdadero, es una de las desventajas.

86. En multiprocesadores, la técnica de SMP no requiere de exclusión mutua para el acceso a las estructuras del kernel.
> Si requiere, es la mas complicada de los 3 enfoques por presentarse el problema de que podemos tener todos los procesadores en modo kernel tratando de usar las mismas estructuras de datos.

87. En multiprocesadores, el uso de cache de CPU para la operación TSL soluciona problema de contención del bus.
> Falso, el problema que Test and Set siempre escribe la palabra de memoria, y hace que las cache se deban sincronizar.

88. No existen diferencias en la planificación de procesos entre SO monoprocesadores y multiprocesadores.
> Falso

89. En un sistema distribuido, todos los SO de las diferente computadoras que participan deben ser los mismos.
> Falso

90. En las multicomputadoras, cada CPU tiene su memoria.
> Verdadero

91. En multicomputadoras, la comunicación entre procesos se realiza por: 
> a. Memoria Compartida  
> b. **Pasajes de Mensajes**  <--  
> c. RPC   
> d. Ninguna   

92. En multicomputadoras, cada nodo puede correr un SO diferente.
> Falso

93. Las computadoras que forman una Grid deben ser todas iguales.
> Falso, es un sistema distribuido, el midleware abstrae las diferencias.

94. El middleware es una capa de software entre el Hardware y el Sistema Operativo 
> Falso

