`Individual Assignment | Nur Afrina binti Mohd Suhaimi | 2022611186 | ITT440`


# FreeBSD Installation on WMware

## Step 1: Downloading FreeBSD

1. Download FreeBSD from the link: https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/14.0/

2. Click the Download FreeBSD in the yellow box shown.

    ![Screenshot (282)](https://github.com/addff/2403-ITT440/assets/166003216/f0cbb23a-b8fb-485d-83c0-9bbeebadd233)

3. Click on FreeBSD 14.0-RELEASE ``Installer`` and choose ``amd64``

    ![Screenshot (283)](https://github.com/addff/2403-ITT440/assets/166003216/a881fefc-8142-45e2-9c59-0028bddf1b29)

4. On the list, choose the ``FreeBSD-14.0-RELEASE-amd64-disc1.iso`` to download.

    ![Screenshot (284)](https://github.com/addff/2403-ITT440/assets/166003216/08b6c421-f169-4a93-9ccc-7f8dc76719b7)




## Step 2: Creating a New Virtual Machine
After downloading the FreeBSD, you need to create a new virtual machine on VMware. Follow these steps:

1. Open VMware and click on "Create a New Virtual Machine."

   ![Screenshot (285)](https://github.com/addff/2403-ITT440/assets/166003216/5bcabf30-ea93-4d0d-b3d1-716c884e21bd)



2. Install FreeBSD disk image file (.iso).

   ![Screenshot (286)](https://github.com/addff/2403-ITT440/assets/166003216/6eff97a6-20b9-4153-bb3c-060ef3735c4c)


## Step 3: FreeBSD Setup

1. Click `install` to start installation.

    ![Screenshot (287)](https://github.com/addff/2403-ITT440/assets/166003216/e19eceaa-0272-44f5-b0d6-bed02f30c581)


2. Click on `Continue with default keymap`.

   ![Screenshot (288)](https://github.com/addff/2403-ITT440/assets/166003216/958a0734-3b19-4f46-a8a3-e588cb95c26c)

3. Choose appropriate hostname.

   ![Screenshot (289)](https://github.com/addff/2403-ITT440/assets/166003216/b46e8e08-838e-45f4-891d-360126cfdfc6)

4. Unticked all optional system components to install by clicking spacebar.

   ![Screenshot (290)](https://github.com/addff/2403-ITT440/assets/166003216/ad3b2fa2-1e23-48c2-86a6-2a16e9f38556)

5. Proceed with Installation.

   ![Screenshot (291)](https://github.com/addff/2403-ITT440/assets/166003216/8e4e02f0-05bd-4342-aacd-b667b5c1f1c5)

6. Tick VMware Virtual S and proceed.

   ![Screenshot (292)](https://github.com/addff/2403-ITT440/assets/166003216/837740bb-65f5-43f1-a099-584462779b6c)

7. Set appropriate password.

      ![Screenshot (293)](https://github.com/addff/2403-ITT440/assets/166003216/602ab9b8-d13b-462d-b127-0f5c478d7490)

8. Click `OK` to continue.

   ![Screenshot (296)](https://github.com/addff/2403-ITT440/assets/166003216/ec5b763e-aef6-47dd-86a5-6eb8222a7963)

9. Insert user’s detail.

    ![Screenshot (295)](https://github.com/addff/2403-ITT440/assets/166003216/cd34c851-9989-4858-b471-b8cef8c8b933)


## Step 4: Open a Shell to make final adjustment

1. Click on "yes" to proceed.

   ![Screenshot (296)](https://github.com/addff/2403-ITT440/assets/166003216/a75addcb-0d55-4b89-b65f-36b5901e39ac)

2.  Enter command (ee /etc/ssh/sshd_config)

       ![Screenshot (297)](https://github.com/addff/2403-ITT440/assets/166003216/2778b0e5-e6b3-4051-a427-e7bdb55c0aac)

3. Remove the hashtag on the beginning of the permit root login and change the permit root
login to ``yes`` from ``no``.

    ![Screenshot (298)](https://github.com/addff/2403-ITT440/assets/166003216/e6a9d751-996b-4040-9b9f-4a9e4325552c)


That's it! You have successfully installed FreeBSD on VMware.
