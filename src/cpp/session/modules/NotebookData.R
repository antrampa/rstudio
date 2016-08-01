#
# NotebookData.R
#
# Copyright (C) 2009-16 by RStudio, Inc.
#
# Unless you have received this program directly from RStudio pursuant
# to the terms of a commercial license agreement with RStudio, then
# this program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#
#

.rs.addFunction("initDataCapture", function(outputFolder, libraryFolder)
{
  assign("print.data.frame", function(x, ...) {
    output <- tempfile(pattern = "_rs_rdata_", tmpdir = outputFolder, 
                       fileext = "rdata")
    save(
      x, 
      file = output)
    .Call("rs_recordData", output);
  }, envir = as.environment("tools:rstudio"))
})

.rs.addFunction("releaseDataCapture", function()
{
  rm("print.data.frame", envir = as.environment("tools:rstudio"))
})

.rs.addFunction("readDataCapture", function(path)
{
  e <- new.env()
  load(file = path, envir = e)

  columns <- unname(lapply(
    names(e$x),
    function(columnName) {
      type <- class(e$x[[columnName]])[[1]]
      list(
        name = columnName,
        type = type,
        align = if (type == "character" || type == "factor") "left" else "right"
      )
    }
  ))

  data <- head(e$x, 1000)

  if (length(columns) > 0) {
    first_column = data[[1]]
    if (is.numeric(first_column) && all(diff(first_column) == 1))
      columns[[1]]$align <- "left"
  }

  list(
    columns = columns,
    data = data
  )
})

.rs.addFunction("packageFilePath", function(path, package) {
  system.file(path, package = package)
})