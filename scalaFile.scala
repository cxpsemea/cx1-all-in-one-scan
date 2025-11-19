import scala.sys.process._

object VulnerableApp {
  def execScript1(scriptname: String): Unit = {
    // Vulnerable command execution
    stringToProcess(scriptname).!
  }
  def execScript2(scriptname: String): Unit = {
    Process(scriptname).run()
  }
  def execScript3(scriptname: String): Unit = {
    Runtime.getRuntime.exec(scriptname)
  }

  def main(args: Array[String]): Unit = {
    if (args.length == 0) {
      println("No script provided")
    } else {
      execScript1(args(0))
      execScript2(args(0))
      execScript3(args(0))
    }
  }
}
