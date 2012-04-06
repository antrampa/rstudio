/*
 * HTMLPreviewPresenter.java
 *
 * Copyright (C) 2009-11 by RStudio, Inc.
 *
 * This program is licensed to you under the terms of version 3 of the
 * GNU Affero General Public License. This program is distributed WITHOUT
 * ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
 * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
 * AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
 *
 */
package org.rstudio.studio.client.htmlpreview;

import org.rstudio.core.client.command.CommandBinder;
import org.rstudio.studio.client.common.GlobalDisplay;
import org.rstudio.studio.client.htmlpreview.model.HTMLPreviewParams;
import org.rstudio.studio.client.workbench.commands.Commands;

import com.google.gwt.user.client.ui.IsWidget;
import com.google.gwt.user.client.ui.Widget;
import com.google.inject.Inject;

public class HTMLPreviewPresenter implements IsWidget
{
   public interface Binder extends CommandBinder<Commands, HTMLPreviewPresenter>
   {}

   
   public interface Display extends IsWidget
   {
      
   }
   
   @Inject
   public HTMLPreviewPresenter(Display view,
                               Binder binder,
                               Commands commands,
                               GlobalDisplay globalDisplay)
   {
      view_ = view;
      globalDisplay_ = globalDisplay;
      
      binder.bind(commands, this);
   }
   
   
   public void onActivated(HTMLPreviewParams params)
   {
   }
  
   
   @Override
   public Widget asWidget()
   {
      return view_.asWidget();
   }

   private final Display view_;
   
   @SuppressWarnings("unused")
   private final GlobalDisplay globalDisplay_;
}
