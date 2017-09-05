//
//  Copyright (C) 2016-2017 Abraham Masri
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

using Gtk;

namespace WallpaperCreator.OnScreen {

    public class InitialPage : Box {

        Grid aboutGrid = new Grid();

        Box titleBox = new Box(Orientation.VERTICAL, 5);
        Label titleLabel = new Label("");
        Label aboutLabel = new Label("");


        Label nameLabel = new Label("Give your wallpaper a name:");
        Entry nameEntry = new Entry() { placeholder_text = "Mountain Summit" };

        FileFilter imageFilter = new FileFilter ();
        FileFilter videoFilter = new FileFilter ();

        Label typeLabel = new Label("My wallpaper is");
        ComboBoxText typeComboBox = new ComboBoxText();

        Label chooseFileLabel = new Label("Where is the image/video located?");
        FileChooserButton chooseFileButton = new FileChooserButton("Choose File", Gtk.FileChooserAction.OPEN);


        public InitialPage() {

            spacing = 10;
            hexpand = true;
            vexpand = true;
            orientation = Orientation.VERTICAL;
            halign = Align.CENTER;
            valign = Align.CENTER;


            aboutGrid.halign = Align.CENTER;
            aboutGrid.margin_bottom = 30;
            aboutGrid.column_spacing = 0;
            aboutGrid.row_spacing = 0;

            titleBox.margin_top = 15;
            titleBox.margin_left = 10;
            titleLabel.halign = Align.START;

            titleLabel.set_markup("<span font='Lato Light 30px' color='white'>Wallpaper Creator</span>");
            aboutLabel.set_markup("<span font='Lato Light 15px' color='white'>for Komorebi by Abraham Masri @cheesecakeufo</span>");

            typeComboBox.append("image", "An image");
            typeComboBox.append("video", "A video");
            typeComboBox.active = 0;

            wallpaperType = "image";

            imageFilter.add_mime_type ("image/*");
            videoFilter.add_mime_type ("video/*");

            chooseFileButton.set_filter (imageFilter);
            chooseFileButton.width_chars = 10;

            // Signals
            nameEntry.changed.connect(() => {

                if(nameEntry.text.length <= 0)
                    wallpaperName = null;
                else
                    wallpaperName = nameEntry.text;
            });

            typeComboBox.changed.connect(() => {
                wallpaperType = typeComboBox.get_active_id();

                if(wallpaperType == "image")
                    chooseFileButton.set_filter (imageFilter);
                else
                    chooseFileButton.set_filter (videoFilter);


            });

            chooseFileButton.file_set.connect (() => {

                filePath = chooseFileButton.get_file().get_path();
            });


            titleBox.add(titleLabel);
            titleBox.add(aboutLabel);

            aboutGrid.attach(new Image.from_file("/System/Resources/Komorebi/wallpaper_creator.svg"), 0, 0, 1, 1);
            aboutGrid.attach(titleBox, 1, 0, 1, 1);

            add(aboutGrid);
            add(nameLabel);
            add(nameEntry);

            add(typeLabel);
            add(typeComboBox);

            add(chooseFileLabel);
            add(chooseFileButton);
        }
    }
}