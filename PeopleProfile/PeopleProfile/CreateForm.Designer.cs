namespace PeopleProfile
{
    partial class CreateForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            btnClear = new Button();
            btnCreate = new Button();
            label1 = new Label();
            txtName = new TextBox();
            txtAge = new TextBox();
            label2 = new Label();
            label3 = new Label();
            picPhoto = new PictureBox();
            btnBrowse = new Button();
            ((System.ComponentModel.ISupportInitialize)picPhoto).BeginInit();
            SuspendLayout();
            // 
            // btnClear
            // 
            btnClear.Location = new Point(26, 18);
            btnClear.Name = "btnClear";
            btnClear.Size = new Size(94, 29);
            btnClear.TabIndex = 0;
            btnClear.Text = "Clear";
            btnClear.UseVisualStyleBackColor = true;
            // 
            // btnCreate
            // 
            btnCreate.Location = new Point(256, 20);
            btnCreate.Name = "btnCreate";
            btnCreate.Size = new Size(94, 29);
            btnCreate.TabIndex = 1;
            btnCreate.Text = "Create";
            btnCreate.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(30, 70);
            label1.Name = "label1";
            label1.Size = new Size(49, 20);
            label1.TabIndex = 2;
            label1.Text = "Name";
            // 
            // txtName
            // 
            txtName.Location = new Point(98, 67);
            txtName.Name = "txtName";
            txtName.Size = new Size(252, 27);
            txtName.TabIndex = 3;
            // 
            // txtAge
            // 
            txtAge.Location = new Point(98, 111);
            txtAge.Name = "txtAge";
            txtAge.Size = new Size(74, 27);
            txtAge.TabIndex = 5;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(30, 114);
            label2.Name = "label2";
            label2.Size = new Size(36, 20);
            label2.TabIndex = 4;
            label2.Text = "Age";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(30, 159);
            label3.Name = "label3";
            label3.Size = new Size(48, 20);
            label3.TabIndex = 6;
            label3.Text = "Photo";
            // 
            // picPhoto
            // 
            picPhoto.Location = new Point(98, 199);
            picPhoto.Name = "picPhoto";
            picPhoto.Size = new Size(250, 268);
            picPhoto.SizeMode = PictureBoxSizeMode.StretchImage;
            picPhoto.TabIndex = 7;
            picPhoto.TabStop = false;
            // 
            // btnBrowse
            // 
            btnBrowse.Location = new Point(98, 159);
            btnBrowse.Name = "btnBrowse";
            btnBrowse.Size = new Size(94, 29);
            btnBrowse.TabIndex = 8;
            btnBrowse.Text = "Browse";
            btnBrowse.UseVisualStyleBackColor = true;
            // 
            // CreateForm
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(369, 479);
            Controls.Add(btnBrowse);
            Controls.Add(picPhoto);
            Controls.Add(label3);
            Controls.Add(txtAge);
            Controls.Add(label2);
            Controls.Add(txtName);
            Controls.Add(label1);
            Controls.Add(btnCreate);
            Controls.Add(btnClear);
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "CreateForm";
            Text = "Creating";
            ((System.ComponentModel.ISupportInitialize)picPhoto).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button btnClear;
        private Button btnCreate;
        private Label label1;
        private TextBox txtName;
        private TextBox txtAge;
        private Label label2;
        private Label label3;
        private PictureBox picPhoto;
        private Button btnBrowse;
    }
}